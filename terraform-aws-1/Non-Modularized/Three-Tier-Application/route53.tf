# 12 Here, Make sure you have created one Route53 hosted zone on AWS through console and map the CName in your domain provider. 
# We are fetching the created hosted zone and create new Route53 Record for CDN and Certificate Manager.

# AWS Route53 zone data source with the domain name and private zone set to false
data "aws_route53_zone" "zone" {
  provider     = aws.use_default_region
  name         = var.domain-name
  private_zone = false
}

# AWS Route53 record resource for certificate validation with dynamic for_each loop and properties for name, records, type, zone_id, and ttl.
resource "aws_route53_record" "cert_validation" {
  provider = aws.use_default_region
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
  ttl             = 60
}


# AWS Route53 record resource for the "www" subdomain. The record uses an "A" type record and an alias to the AWS CloudFront distribution with the specified domain name and hosted zone ID. The target health evaluation is set to false.
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.id
  name    = "www.${var.domain-name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn-web-elb-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cdn-web-elb-distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# AWS Route53 record resource for the apex domain (root domain) with an "A" type record. The record uses an alias to the AWS CloudFront distribution with the specified domain name and hosted zone ID. The target health evaluation is set to false.
resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.zone.id
  name    = var.domain-name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn-web-elb-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cdn-web-elb-distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
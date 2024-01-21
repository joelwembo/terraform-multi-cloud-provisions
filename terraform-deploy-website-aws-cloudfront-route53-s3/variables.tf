# S3 bucket name
variable "bucket-name" {
  default = "socialcloudsync-bucket"
}

# Domain name that you have registered
variable "domain-name" {
  default = "cloudapp.io" // Modify as per your domain name
}

variable "AWS_ACCESS_KEY_ID" {
  default = ""
}
variable "AWS_SECRET_ACCESS_KEY" {
  default = ""
}
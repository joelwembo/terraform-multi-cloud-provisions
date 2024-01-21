# terraform {
#   backend "s3" {
#     bucket         = "my-ews-baket2"
#     region         = "us-east-1"
#     key            = "Non-Modularized/S3-Static-Website/terraform.tfstate"
#     dynamodb_table = "Lock-Files"
#     encrypt        = true
#   }
#   required_version = ">=0.13.0"
#   required_providers {
#     aws = {
#       version = ">= 2.7.0"
#       source  = "hashicorp/aws"
#     }
#   }
# }
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    token = "token here"
    organization = "cloudapp"
    workspaces {
      name = "cloudapp"
    }
  }

}

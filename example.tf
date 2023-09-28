provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
}

resource "aws_instance" "client-ether-1" {
  ami           = "ami-0b7e55206a0a22afc"
  instance_type = "t2.micro"
}


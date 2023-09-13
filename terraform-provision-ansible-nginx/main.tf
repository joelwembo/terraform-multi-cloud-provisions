locals {
  vpc_id           = "vpc-0a1402d57b83141f8"
  subnet_id        = "vpc-0a1402d57b83141f8"
  ssh_user         = "ubuntu"
  key_name         = "ProctKeyPair"
  private_key_path = "ProctKeyPair.pem"
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_security_group" "nginx" {
  name   = "nginx_access"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx" {
  ami                         = "ami-002843b0a9e09324a"
  subnet_id                   = "subnet-048acdf9d5c72e624"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx.id]
  key_name                    = local.key_name

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.nginx.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i 18.143.159.175 --private-key ProctKeyPair.pem nginx.yaml"
  }
}

output "nginx_ip" {
  value = aws_instance.nginx.public_ip
}
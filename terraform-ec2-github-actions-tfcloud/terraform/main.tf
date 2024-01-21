# Terraform provision AWS EC2 instance with Terraform Cloud Management

variable "awsprops" {
  type = map(any)
  default = {
    region       = "ap-southeast-1"
    vpc          = "vpc-0a1402d57b83141f8"
    ami          = "ami-002843b0a9e09324a"
    itype        = "t2.micro"
    subnet       = "subnet-05022dde7d80a109b"
    publicip     = true
    keyname    = "ProctKeyPair"
    secgroupname = "prodx-Sec-Group-3"
  }
}

// AMI Security group setting using HashiCorp Configuration Language (HCL)
resource "aws_security_group" "prod-sec-sg" {
  name        = var.instance_secgroupname
  description = var.instance_secgroupname
  vpc_id      = var.instance_vpc_id

  // To Allow SSH Transport

   dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description      = lookup(ingress.value, "description", null)
      from_port        = lookup(ingress.value, "from_port", null)
      to_port          = lookup(ingress.value, "to_port", null)
      protocol         = lookup(ingress.value, "protocol", null)
      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_tls"
  }

  lifecycle {
    create_before_destroy = true
  }
}


# instance identity
resource "aws_instance" "project-iac" {
  ami                         = lookup(var.awsprops, "ami")
  instance_type               = lookup(var.awsprops, "itype")
  subnet_id                   = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name                    = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
    aws_security_group.prod-sec-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    volume_size           = 50
    volume_type           = "gp2"
  }
  tags = {
    Name        = "ec2-kubernets"
    Environment = "DEV"
    OS          = "UBUNTU"
    Managed     = "IAC"
  }

  provisioner "file" {
    source      = "installer.sh"
    destination = "/tmp/installer.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/installer.sh",
      "sh /tmp/installer.sh"
    ]

  }

  depends_on = [aws_security_group.prod-sec-sg]


  # Single Jenkins Only installation in ec2
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get install debian-keyring debian-archive-keyring --assume-yes",
  #     "sudo apt-key update",
  #     "sudo apt-get update",
  #     "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5",
  #     "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5BA31D57EF5975CA",
  #     "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32",
  #     "sudo apt update",
  #     "sudo apt install openjdk-11-jre-headless --assume-yes",
  #     "sudo java -version",
  #     "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
  #     "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
  #     "sudo apt-get update",
  #     "sudo apt-get install jenkins --assume-yes",
  #     # "sudo service jenkins status",
  #     "echo 'Jenkins installation completed",
  #     "exit",
  #   ]
  # }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("./ProctKeyPair.pem")
  }
}

output "ec2instance" {
  value = aws_instance.project-iac.public_ip
}


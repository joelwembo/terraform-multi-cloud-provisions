variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "backend_organization" {
  type    = string
  default = "cloudapp"
}

variable "backend_worspaces" {
  type    = string
  default = "cloudapp"
}

variable "access_key" {
  default = "AKIAYZITHA4UUEUQFMY7"
}
variable "secret_key" {
  default = "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"
}

variable "bucket" {
  default = "bucket"
}


variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "subnet" {
  default = "10.0.0.0/24"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  type    = string
  default = "ami-002843b0a9e09324a"
}

variable "instance_vpc_id" {
  type    = string
  default = "vpc-0a1402d57b83141f8"
}

variable "instance_subnet_id" {
  type    = string
  default = "subnet-05022dde7d80a109b"
}

variable "instance_keyName" {
  type    = string
  default = "ProctKeyPair"
}

variable "instance_secgroupname" {
  description = "This is a security Group Name"
  type    = string
  default = "prodx-Sec-Group-3"
}

variable "instance_publicip" {
  type    = bool
  default = true
}

variable "aws_availability_zone" {
  type    = string
  default = "ap-southeast-1b"
}


variable "ingress_rules" {
  default     = {
    "my ingress rule" = {
      "description" = "For HTTP"
      "from_port"   = "80"
      "to_port"     = "80"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    "my other ingress rule" = {
      "description" = "For SSH"
      "from_port"   = "22"
      "to_port"     = "22"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },

     "Postgres port" = {
      "description" = "For HTTP postgres"
      "from_port"   = "5432"
      "to_port"     = "5432"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },

    "Jenkins port" = {
      "description" = "For Jenkins"
      "from_port"   = "8080"
      "to_port"     = "8080"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  }
  type = map(object({
  description = string
  from_port   = number
  to_port     = number
  protocol    = string
  cidr_blocks = list(string)
  }))
  description = "Security group rules"
}
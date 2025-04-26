variable "instance_type"{
  description = "EC2 Instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "EC2 AMI ID"
  type        = string
}

provider "aws" {
  region      = "us-east-1"
}

resource "Aws_instance" "example1" {
  ami           = var.ami_id
  instance_type = var.instance_type
}

output "public_ip" {
  description    = "Public IP of EC2"
  value          = aws_instance.example1.public_ip
}

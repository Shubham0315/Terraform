provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "This is AMI for the instance"
}

variable "instance_type" {
  description = "Instance Type: t2.micro"
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
}

provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name = "shubham-ec2"
  instance_tupe = "t2.micro"
  ami = "ami-0c55b159cbfafe1f0"

  key_name = "shubham-keyValue"

  vpc_security_group_ids = ["sg-0123456789abcdef0"]
  subnet_id = "subnet-0123456789abcdef0"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

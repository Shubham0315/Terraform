provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}

resource "aws_instance" "example1" {
  ami = "ami-xxxxxx"
  instance_type = "t2.micro"
  provider = "aws.us-east-1"
}

resource "aws_instance" "example2" {
  ami = "ami-xxxxxx"
  instance_type = "t2.micro"
  provider = "aws.us-east-2"
}

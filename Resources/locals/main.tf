provider "aws" {
  region = local.region
}

resource "aws_instance" "shubham" {
  instance_type = local.instance_type
}

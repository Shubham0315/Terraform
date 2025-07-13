resource "aws_vpc" "shuham" {
  cidr_block = var.vpc_cidr
  tags       = {
    Name= var.name
  }
}

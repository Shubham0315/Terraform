variable "is_prod" {
  type = bool
  default - false
}

resource "aws_instance" "shubham" {
  instance_type = var.is_prod ? "t3.large" : "t2.micro"
}

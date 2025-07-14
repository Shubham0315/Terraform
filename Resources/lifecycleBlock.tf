resource "aws_instance" "shubham" {
  ami = "xxxxx"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }

  lifecycle {
    ignore_changes = [ami]
  }
}

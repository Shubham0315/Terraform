variables "instance_type" {
  description = "EC2 Type"
  default = "t2.micro"
}

resource "aws_instance" "shubham" {
  ami = "xxxxx"
  instance_type = var.instance_type
}

output "instance_id" {
  value = aws_instance.shubham.id
}  

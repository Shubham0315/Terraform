provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "example" {
    ami           = "ami-084568db4383264d4"  
    instance_type = "t2.micro"
    subnet_id = "subnet-xxxxxx"
    key_name = "aws_login"
}

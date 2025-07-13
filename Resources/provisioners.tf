local-exec

resource "aws_instance" "shubham" {
  ami = "xxxxx"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command - "echo ${self.public_ip} > ip_address.txt"
  }
}


remote-exec

resource "aws_instance" "shubham" {
  ami = "xxxxx"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip
  }
}


file

provisioner "file" {
  source = "script.sh"
  destination = "/tmp/script.sh"
}

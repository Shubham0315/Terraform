provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://98.81.145.235:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "0f75dec3-21cf-76ff-0765-271b6d8626b2"
      secret_id = "a4f0f353-48e1-1535-637f-e6457d508a3c"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv" 
  name  = "test-secret"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    secret = data.vault_kv_secret_v2.example.data["username"]
  }
}

terraform {
  backend "s3" {
    bucket = "shubham-s3-0315"
    region = "us-east-1"
    key = "shubham/terraform.tfstate"
    dynamodb_table = "terraform_lock"
  }
}

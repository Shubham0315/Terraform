module "s3_bucket" {
  source = "terraform-aws-modules/s3/aws"
  version = "~> 4.0"

  bucket = "shubham-s3-bucket"
  acl = "private"

  block_public_acls = false
  block_public_policy = false

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Owner = "WebTeam"
    Environment = "Prod"
  }

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        see_algorithm = "AES256"
      }
    }
  }

  tags = {
    Owner = "DevOps"
    Environment = "Dev"
  }
}

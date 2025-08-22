

module "lambda-function" {
  source = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "shubham_lambda"
  description = "My Lambda"
  handler = "index.handler"
  runtime = "python3.9"

  source_path = "./src"

  envoironment_variables = {
    ENV = "dev"
  }

  tags = {
    Owner = "DevOps"
    Environment = "Dev"
  }
}

}

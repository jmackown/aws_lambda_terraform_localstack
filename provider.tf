# local

terraform {
  backend "local" {}
    required_providers {
    aws = {
      version = ">= 3.63.0"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {

  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  region                      = "eu-west-1"

  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3             = "http://s3.localhost.localstack.cloud:4566"
    iam            = "http://iam.localhost.localstack.cloud:4566"
    lambda         = "http://lambda.localhost.localstack.cloud:4566"
  }
}

resource "aws_s3_bucket" "test-bucket" {
  bucket = "lambda-bucket"
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = file("lambda_policy.json")
}
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = file("lambda_assume_role_policy.json")
}


resource "aws_lambda_function" "test_lambda" {
  function_name = "welcome"
  s3_bucket     = "lambda-bucket"
  s3_key        = "app.zip"
  role          = aws_iam_role.lambda_role.arn
  handler       = "app.hello.welcome"
  runtime       = "python3.9"
}




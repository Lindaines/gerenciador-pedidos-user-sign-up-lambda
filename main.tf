terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
  backend "s3" {
    bucket = "gerenciador-pedidos-user-sign-up-lambda"
    region = "us-east-1"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_id
  secret_key = var.aws_secret
}

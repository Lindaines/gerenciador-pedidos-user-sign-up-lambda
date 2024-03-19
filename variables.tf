variable "jwtSecret" {
  description = "JWT Secret"
  sensitive   = true
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_s3_bucket" {
  description = "S3 Bucket for Zip"
}

variable "aws_cognito_pool_user_id" {
  description = "Cognito Pool UserId"
  sensitive = true
}

variable "aws_access_id" {
  description = "AWS access ID"
  sensitive = true
}

variable "aws_secret" {
  description = "AWS Secret"
  sensitive = true
}


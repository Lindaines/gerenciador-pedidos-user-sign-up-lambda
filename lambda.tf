data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/api"
  output_path = "${path.module}/zip/api.zip"
}

resource "aws_s3_object" "lambda" {
  bucket = var.aws_s3_bucket
  key    = "api.zip"
  source = data.archive_file.lambda.output_path
  etag   = filemd5(data.archive_file.lambda.output_path)
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_execution_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_lambda_function" "cognito_lambda" {
  function_name    = "cognitoSignUpLambda"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  filename         = "${path.module}/zip/api.zip" // Path to your Lambda code ZIP file

  }


  tracing_config {
    mode = "Active"
  }

  source_code_hash = data.archive_file.lambda.output_base64sha256


  role = aws_iam_role.lambda_role.arn



}

resource "aws_cloudwatch_log_group" "cloudwatch" {
  name              = "/aws/lambda/cognitoValidationFunction"
  retention_in_days = 1
}
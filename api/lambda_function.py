import boto3
import json


def lambda_handler(event, context):
    request_body = event.get('input').get('body')
    username = json.loads(request_body).get('username')
    email = json.loads(request_body).get('email')
    aws_client = boto3.client('cognito-idp', region_name="us-east-1")
    response = aws_client.admin_create_user(
        UserPoolId="us-east-1_QyvJEcO3L",
        Username=username,
        TemporaryPassword=username,
        UserAttributes=[
            {"Name": "email", "Value": email},
        ],
    )
    return response


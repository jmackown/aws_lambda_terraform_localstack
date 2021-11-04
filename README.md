aws_lambda_terraform_localstack

## To Run

```bash
docker-compose up -d

terraform init

terraform apply
```

### Problems

Terraform claims to have created the lambda function correctly, 
but when I try to list or get the functions I get nothing:

###### Get:
```bash
aws lambda --endpoint http://localhost:4566 get-function --function-name welcome
```

returns `An error occurred (ResourceNotFoundException) when calling the GetFunction operation: Function not found: arn:aws:lambda:eu-west-1:000000000000:function:welcome
`

###### List
```bash
aws lambda list-functions --endpoint-url http://localhost.localstack.cloud:4566
```

returns 
`{
    "Functions": []
}
`


Arrrrrggg
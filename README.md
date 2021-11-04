aws_lambda_terraform_localstack

## To Run

```bash
docker-compose up -d

terraform init

terraform apply
```

Check if function has been created:

```bash
aws lambda list-functions --endpoint-url http://lambda.localhost.localstack.cloud:4566
```

Invoke the function!

```bash
aws lambda invoke --function-name lambda_using_terraform --endpoint-url http://lambda.localhost.localstack.cloud:4566 response.json
```
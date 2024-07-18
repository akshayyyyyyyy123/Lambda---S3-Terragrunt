
terraform {
    source = "../..//modules/s3"
}

dependency "lambda" {
    config_path = "../lambda"
}

inputs = {
    bucket_name = "akshay-test-bucket-unique-suffix"
    lambda_arn = dependency.lambda.outputs.lambda_function_arn
}
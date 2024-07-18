
terraform {
    source = "../..//modules/lambda"
}

inputs = {
  role_name = "LamdaCloudWatchLogging Role"
  lambda_policy_name = "AkshayLambdaS3TriggerPolicy"
  lambda_function_name = "akshay-test-lambda"
  runtime = "python3.8"
  lambda_tag = "staging-lambda"
}
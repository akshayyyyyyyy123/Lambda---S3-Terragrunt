
# create an assume role / trust policy for lambda service
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# iam policy that allows lambda to create log groups, create log streams, and put log events on Cloudwatch
resource "aws_iam_policy" "lambda_logging_policy" {
  name        = var.lambda_policy_name
  description = "Policy to allow Lambda to log to CloudWatch"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        # The policy applies to all CloudWatch Logs resources (log groups, log streams) across all regions 
        # and all AWS accounts.
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# create a role for aws lambda service
resource "aws_iam_role" "lambda_iam_role" {
  name = "my_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
} 

# attach lambda-logging-policy to the role
resource "aws_iam_role_policy_attachment" "lambda_logging_policy_attachment" {
  role = aws_iam_role.lambda_iam_role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}

# creates a zip file of the python code
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "code.py"
  output_path = "lambda_function_payload.zip"
}

# lambda function configuration
resource "aws_lambda_function" "test_lambda" {
  filename      = var.filename
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_iam_role.arn
  handler       = "code.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = var.runtime

  tags = {
    Name = var.lambda_tag
  }  
}











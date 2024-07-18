
variable "role_name" {
  type = string
  default = "my_lambda_role"
}

variable "lambda_policy_name" {
  type = string
}

variable "filename" {
  type = string
  default = "lambda_function_payload.zip"
}

variable "lambda_function_name" {
  type = string
}

variable "runtime" {
  type = string
  default = "python3.8"
}

variable "lambda_tag" {
  type = string
  default = "staging-lambda"
}
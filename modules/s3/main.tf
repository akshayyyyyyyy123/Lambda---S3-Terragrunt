
resource "aws_s3_bucket" "example-bucket" {
  bucket = var.bucket_name
  tags = {
    Name = "staging-bucket"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
   bucket = aws_s3_bucket.example-bucket.id

   lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
   }

   depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.example-bucket.arn
}

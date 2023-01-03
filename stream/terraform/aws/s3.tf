resource "aws_s3_bucket" "example" {
  bucket = "dynamodb-to-bigquery-example"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_notification" "example" {
  bucket = aws_s3_bucket.example.id

  queue {
    queue_arn = aws_sqs_queue.example.arn
    events    = ["s3:ObjectCreated:*"]
  }
}

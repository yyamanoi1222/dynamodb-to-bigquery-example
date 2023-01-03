resource "aws_kinesis_stream" "example" {
  name        = "dynamodb-changes"
  shard_count = 1
}

resource "aws_dynamodb_kinesis_streaming_destination" "example" {
  stream_arn = aws_kinesis_stream.example.arn
  table_name = aws_dynamodb_table.example.name
}

resource "aws_kinesis_firehose_delivery_stream" "example" {
  name        = "example-stream"
  destination = "extended_s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.example.arn
    role_arn           = aws_iam_role.firehose_role.arn
  }

  extended_s3_configuration {
    role_arn        = aws_iam_role.firehose_role.arn
    bucket_arn      = aws_s3_bucket.example.arn
    buffer_interval = 60
    buffer_size     = 1
  }
}

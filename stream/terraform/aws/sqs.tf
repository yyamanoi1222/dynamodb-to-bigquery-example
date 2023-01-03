resource "aws_sqs_queue" "example" {
  name = "example"

  policy = <<POLICY
  {
    "Version": "2012-10-17",
      "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "sqs:SendMessage",
        "Resource": "arn:aws:sqs:*:*:example",
        "Condition": {
          "ArnEquals": { "aws:SourceArn": "${aws_s3_bucket.example.arn}" }
        }
      }
      ]
  }
POLICY
}

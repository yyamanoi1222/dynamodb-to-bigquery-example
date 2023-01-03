resource "aws_iam_role" "firehose_role" {
  name = "firehose_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "firehose_policy" {
  name = "firehose_policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:DescribeStream",
        "kinesis:GetShardIterator",
        "kinesis:GetRecords",
        "kinesis:ListShards"
      ],
      "Resource": "${aws_kinesis_stream.example.arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.example.arn}",
        "${aws_s3_bucket.example.arn}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "firehose_role" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.firehose_policy.arn
}

resource "aws_iam_role" "gcp_storage_transfer_role" {
  name = "gcp_storage_transfer_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "accounts.google.com"
      },
      "Effect": "Allow",
      "Sid": "",
      "Condition": {
        "StringEquals": {
          "accounts.google.com:sub": "${var.service_account_subject_id}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "gcp_storage_transfer_policy" {
  name = "gcp_storage_transfer_role"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.example.arn}",
        "${aws_s3_bucket.example.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:*"
      ],
      "Resource": "${aws_sqs_queue.example.arn}"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "gcp_storage_transfer_role" {
  role       = aws_iam_role.gcp_storage_transfer_role.name
  policy_arn = aws_iam_policy.gcp_storage_transfer_policy.arn
}


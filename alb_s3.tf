data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "logs" {
  bucket_prefix = "nubi-alb-logs-"
  force_destroy = true

  # Default encryption

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # To reduce costs, we'll transition to cheaper storage classes when logs are 30, 60 and 90 days older.

  lifecycle_rule {
    id      = "log"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }

}

data "aws_iam_policy_document" "logs_bucket_policy" {
  statement {
    sid       = "Allow LB to write logs"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.logs.bucket}/*"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.main.arn]
    }
  }

  statement {
    sid       = "Permit access log delivery by AWS ID for Log Delivery service"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.logs.bucket}/*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::858827067514:root"]
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.bucket
  policy = data.aws_iam_policy_document.logs_bucket_policy.json
}
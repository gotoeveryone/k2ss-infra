resource "aws_s3_bucket" "internal_resource" {
  bucket = "${var.app_name}-internal-resource"
}

resource "aws_s3_bucket_versioning" "internal_resource" {
  bucket = aws_s3_bucket.internal_resource.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "internal_resource" {
  bucket = aws_s3_bucket.internal_resource.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "internal_resource" {
  bucket                  = aws_s3_bucket.internal_resource.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

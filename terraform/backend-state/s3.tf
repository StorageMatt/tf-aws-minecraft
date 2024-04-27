resource "random_id" "remote_state" {
  byte_length = 2
}

resource "aws_s3_object" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  key    = "terraform-aws/minecraft_server/"
}

resource "aws_kms_key" "remote_state" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(
    {
      Name = "Minecraft Key for s3 bucket at rest encryption"
    },
    var.additional_tags,
  )
}

resource "aws_s3_bucket" "remote_state" {
  bucket = "${var.aws_s3_state_bucket_name}-${random_id.remote_state.dec}"

  tags = merge(
    {
      Name = "Minecraft State Bucket"
    },
    var.additional_tags,
  )
}

resource "aws_s3_bucket_ownership_controls" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "remote_state" {
  depends_on = [aws_s3_bucket_ownership_controls.remote_state]

  bucket = aws_s3_bucket.remote_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.remote_state.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_logging" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  target_bucket = aws_s3_bucket.remote_state_logs.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "remote_state_logs" {
  bucket = "${var.aws_s3_state_bucket_name}-${random_id.remote_state.dec}-logging"

  tags = merge(
    {
      Name = "Minecraft State Logging Bucket"
    },
    var.additional_tags,
  )
}

resource "aws_s3_bucket_acl" "remote_state_logs" {
  bucket = aws_s3_bucket.remote_state_logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "remote_state_logs" {
  bucket = aws_s3_bucket.remote_state_logs.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.remote_state.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-remote_state_logs" {
  bucket = aws_s3_bucket.remote_state_logs.id

  rule {
    id = "log"

    expiration {
      days = 90
    }

    filter {}

    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }

  rule {
    id = "large"

    filter {
      object_size_greater_than = 64000
    }

    expiration {
      days = 7
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "remote_state_logs" {
  bucket = aws_s3_bucket.remote_state_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

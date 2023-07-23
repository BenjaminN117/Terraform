// Setup the S3 bucket to hold the backend configs

resource "aws_s3_bucket" "dev_terraform_profile" {
  bucket = "dev-terraform-profile"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    "Name" = "dev-terraform-profile",
    "Environment" = "Development",
    "Service" = "Terraform"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dev_terraform_profile_SSE_config" {
  bucket = aws_s3_bucket.dev_terraform_profile.id
  
  rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}

resource "aws_s3_bucket_versioning" "dev_terraform_profile_versioning_config" {
  bucket = aws_s3_bucket.dev_terraform_profile.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

// Setup DB for storing S3 key

resource "aws_dynamodb_table" "dev_terraform_lock" {
  name = "dev-terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  deletion_protection_enabled = true

  lifecycle {
    prevent_destroy = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Name" = "dev-terraform-lock",
    "Environment" = "Development",
    "Service" = "Terraform"
  }
}
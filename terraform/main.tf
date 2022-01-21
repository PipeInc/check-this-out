locals {
  bucket_name = "${random_pet.this.id}-website"
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]
    resources = [
      "${module.s3-host-bucket.s3_bucket_arn}/*",
    ]
  }
}

resource "random_pet" "this" {
  length = 2
}

#tfsec:ignore:AWS052
module "s3-host-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.13.0"

  bucket = local.bucket_name
  acl    = "public-read"

  attach_policy = true
  policy        = data.aws_iam_policy_document.allow_public_access.json

  versioning = {
    enabled = false
  }

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
  # S3 bucket-level Public Access Block configuration
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  # S3 Bucket Ownership Controls
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  force_destroy = true
}

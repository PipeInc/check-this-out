data "aws_canonical_user_id" "current" {}

terraform {
  required_version = ">=1.1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.72.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

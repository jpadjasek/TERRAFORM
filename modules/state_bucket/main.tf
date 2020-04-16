provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "jpadjasek_terraform_state" {
  bucket = "jpadjasek-terraform"
  # Enable versioning so we can see the full revision history of our
  # state files
}

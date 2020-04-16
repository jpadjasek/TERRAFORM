provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "jpadjasek-terraform"
    key    = "dev1/terraform.tfstate"
    region = "eu-west-2"
  }
}

module "all" {
  source       = "./modules/all"
  project_name = var.project_name
  stage        = var.stage
}

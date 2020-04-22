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
  source         = "./modules/all"
  project_name   = var.project_name
  stage          = var.stage
  cidr_vpc       = "10.2.0.0/16"
  cidr_subnet    = "10.2.1.0/24"
  cidr_subnet_2  = "10.2.2.0/24"
}

module "ec2" {
  source                  = "./modules/ec2"
  project_name            = var.project_name
  stage                   = var.stage
  security_group_id       = module.all.security_group_id
  subnet_id_1             = module.all.subnet_id_1
  subnet_id_2             = module.all.subnet_id_2
}

module "rds" {
  source               = "./modules/rds"
  project_name         = var.project_name
  stage                = var.stage
  cidr_vpc             = "10.2.0.0/16"
  cidr_subnet          = "10.2.1.0/24"
  cidr_subnet_2        = "10.2.2.0/24"
  db_subnet_group_name = module.all.subnet_group_name
}

terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
      }
    }
  required_version = ">= 1.4.0"
}

# conexión con AWS
provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region     = var.region
}

data "aws_caller_identity" "current" {}

module "policies" {
  source = "./modules/policies"
  bucket_name = var.bucket_name
  central_name = var.central_name
  region = var.region
  database_glue = var.database_glue
  s3_bucket_arn  = module.s3.s3_bucket_arn
  s3_bucket_iam_arn = module.policies.aws_iam_policy_arn[0]
  create_policy = var.create_policy
  aws_iam_policy = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/s3-policy"
}

module "user" {
  source = "./modules/user"
  central_name = var.central_name
  s3_bucket_iam_arn = module.policies.aws_iam_policy_arn[0]
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

module "database_glue" {
  source = "./modules/database_glue"
  bucket_name = var.bucket_name
  central_name = var.central_name
  region = var.region
}

module "glue" {
  source = "./modules/glue"
  bucket_name = var.bucket_name
  aws_glue_catalog_database = module.database_glue.aws_glue_catalog_database #var.aws_glue_catalog_database
  central_name = var.central_name
  region = var.region
}
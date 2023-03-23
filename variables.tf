# Declaración de variables 
variable "region" {
  description = "AWS region"
  default = "us-east-2"
}

variable "bucket_name" {
  type = string
  default = "s3-bucket-terraform-1"
}

variable "central_name" {
  type    = string
  default = "dfajardo"
}

variable "create_policy" {
  type    = bool
  default = true
}

variable "database_glue" {
  type = string
  default = "glue-database-terraform"
}
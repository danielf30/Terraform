variable "bucket_name" {
  type = string
}

variable "central_name" {
  type    = string
}

variable "s3_bucket_arn" {
  type = string
}

variable "s3_bucket_iam_arn" {
  description = "El ARN de la política IAM para el acceso bucket S3"
  type = string
}

variable "create_policy" {
  type    = bool
}

variable "aws_iam_policy" {
  type = string
}

variable "region" {
  type = string
}

variable "database_glue" {
  type = string
}
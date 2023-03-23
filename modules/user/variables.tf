variable "central_name" {
  type    = string
}

variable "s3_bucket_iam_arn" {
  description = "El ARN de la política IAM para el acceso bucket S3"
  type = string
}

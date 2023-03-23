variable "region" {
  description = "AWS region"
}

variable "central_name" {
  type    = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
}

variable "aws_glue_catalog_database" {
  description = "Identificador id catalog para la BD creada"
}

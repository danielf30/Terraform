resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
#   acl    = "private"
  tags   = {
    Name = "My Example Bucket"
  }
}

resource "aws_s3_bucket_object" "folder_input" {
  bucket = aws_s3_bucket.my_bucket.id
  key = "Input/"
  content_type = "application/x-directory"
}

resource "aws_s3_bucket_object" "folder_process" {
  bucket = aws_s3_bucket.my_bucket.id
  key = "Scripts/"
  content_type = "application/x-directory"
}

resource "aws_s3_bucket_object" "folder_output" {
  bucket = aws_s3_bucket.my_bucket.id
  key = "Output/"
  content_type = "application/x-directory"
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.id
  acl    = "private"
}

output "bucket_name" {
  # declarar la variable name como salida
  value = aws_s3_bucket.my_bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}
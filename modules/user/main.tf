resource "aws_iam_user" "example" {
  name = var.central_name
  lifecycle {
    ignore_changes = [name] # Ignorar cambios en el atributo "name"
  }
  count = length(data.aws_iam_user.example.user_name) > 0 ? 0 : 1

  tags = {
    Name = var.central_name
  }
}

data "aws_iam_user" "example" {
  user_name = var.central_name
}

# Asociar la política con el usuario o el rol
## El recurso aws_iam_user_policy_attachment adjunta una política de IAM a un usuario de IAM específico en AWS.
resource "aws_iam_user_policy_attachment" "s3_attachment" {
  count = length(data.aws_iam_user.example.user_name) > 0 ? 1 : 0
  user       = data.aws_iam_user.example.user_name
  policy_arn = var.s3_bucket_iam_arn
}
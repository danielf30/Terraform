# conexión con AWS
provider "aws" {
  region     = var.region
  profile = "default"
}

data "aws_caller_identity" "current" {}

# resource "aws_glue_connection" "my_connection" {
#   name = "nequi-${var.central_name}-my_connection"
#   connection_type = "JDBC"
#   connection_properties = {
#     # "JDBC_CONNECTION_URL" = "jdbc:aws:glue://${var.aws_glue_catalog_database}.${var.region}.glue.amazonaws.com"
#     # "JDBC_CONNECTION_URL" = "jdbc:aws:glue://nequi-dfajardo-data-base-catalog.us-east-2.glue.amazonaws.com"
#     "JDBC_CONNECTION_URL" = "jdbc:aws:glue://397482730725.us-east-2.glue.amazonaws.com"
#     "JDBC_ENFORCE_SSL" = "true"    
#   }
# }

resource "aws_glue_job" "my_job" {
  name = "nequi-${var.central_name}-job-glue"
  description = "Mi trabajo de prueba"
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/glue_job_role"
  command {
    name = "nequi-${var.central_name}-glueetl"
    script_location = "s3://${var.bucket_name}/Scripts/sample-connection.py"
  }
  default_arguments = {
    "--job-language" = "python"
    #  "--connections"  = "${aws_glue_connection.my_connection.name}"
  }
}

# conexión con AWS
provider "aws" {
  region     = var.region  
  profile = "default"
}

resource "aws_glue_catalog_database" "my_database" {
  name = "dominio-${var.central_name}-data-base-catalog"
  description = "Mi base de datos de prueba"
}

resource "aws_glue_catalog_table" "my_table" {
  name = "dominio-${var.central_name}-table-catalog"
  database_name = aws_glue_catalog_database.my_database.name
  table_type = "EXTERNAL_TABLE"
  parameters = {
    "classification" = "csv"
  }
  storage_descriptor {
    location = "s3://${var.bucket_name}/Input"
    input_format  = var.input_format
    output_format = var.output_format    
    ser_de_info {
      serialization_library = var.serialization
      parameters = {
        "field.delim" = ","
      }
    }
  }
}

output "aws_glue_catalog_database" {
  # declarar la variable name como salida
  value = aws_glue_catalog_database.my_database.id
}

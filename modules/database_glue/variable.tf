variable "region" {
  description = "AWS region"
}

variable "central_name" {
  type    = string
}

# variable "input_format" {
#   type = list(string)
#   default = ["org.apache.hadoop.mapred.TextInputFormat", "org.apache.hadoop.io.compress.GzipCodec", "org.apache.hadoop.mapred.csv.CSVLineRecordReader", ",", "", "IGNORE_HEADER"]
# }


# variable "output_format" {
# type = list(string)
# default = ["org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat", "org.apache.hadoop.io.compress.GzipCodec", "org.apache.hadoop.mapred.TextOutputFormat", "|", ""]
# }

variable "input_format" {
  type    = string
  default = "org.apache.hadoop.mapred.csv.CSVLineRecordReader,IGNORE_HEADER"
}

variable "output_format" {
  type    = string
  default = "org.apache.hadoop.mapred.TextOutputFormat"
}


variable "serialization" {
  type    = string
  default = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
}

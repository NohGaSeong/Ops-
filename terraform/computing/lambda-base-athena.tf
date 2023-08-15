resource "aws_athena_data_catalog" "lambda-base-athena" {
  name = "athena-data-catalog"
  description = "this is description"
  type = "LAMBDA"

  parameters = {
    "function" = var.athena_function
  }

  tags = {
    Name = "gaseong-lambda-base-athena"
  }
}

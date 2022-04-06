resource "aws_lambda_function" "nif_function" {
  filename         = "${path.module}/files/lambda.zip"
  function_name    = "nif-lamda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "nif-lambda.handler"
  source_code_hash = data.archive_file.lambda_archive.output_base64sha256
  runtime          = "python3.9"
  timeout          = "60"
  tags = {
    "Name" : "nif-lamda",
    "Env" : var.environment
  }
}

data "archive_file" "lambda_archive" {
  type        = "zip"
  source_dir  = "${path.module}/src/"
  output_path = "${path.module}/files/lambda.zip"
}
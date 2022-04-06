
resource "aws_iam_role" "lambda_role" {
  name               = "nif-lambda-execution-role"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
  tags = {
    "Name": "nif-lambda-execution-role",
    "Env": var.environment
  }
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_permissions" {
  statement {
    actions = [
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "lambda_perms_policy" {
  name   = "nif-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_permissions.json
}
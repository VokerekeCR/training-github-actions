terraform {
  backend "s3" {
    key            = "sprint1/week2/training-lambda/terraform.tfstates"
    region         = "us-east-1"
    bucket         = "victor-talent-academy-686520628199-tfstates"
    dynamodb_table = "tf-lock-table"
    encrypt        = true
  }
}
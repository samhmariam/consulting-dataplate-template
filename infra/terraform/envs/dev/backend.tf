terraform {
  backend "s3" {
    bucket = "REPLACE_WITH_STATE_BUCKET"
    key    = "sovereign-tea/dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "REPLACE_WITH_LOCK_TABLE"
  }
}

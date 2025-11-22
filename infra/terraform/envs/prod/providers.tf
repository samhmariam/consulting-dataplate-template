terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }

    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = ">= 0.94.0"
    }

    airbyte = {
      source  = "airbytehq/airbyte"
      version = ">= 0.5.4"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "snowflake" {
  account  = var.snowflake_account
  username = var.snowflake_user
  password = var.snowflake_password
  role     = var.snowflake_role
}

provider "airbyte" {
  host    = var.airbyte_host
  api_key = var.airbyte_api_key
}

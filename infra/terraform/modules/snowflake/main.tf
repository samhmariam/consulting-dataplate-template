terraform {
  required_version = ">= 1.6.0"
}

locals {
  component = "snowflake"
  tags = merge(
    var.default_tags,
    {
      component   = local.component
      environment = var.environment
    }
  )
}

# Provision Snowflake objects (databases, warehouses, roles, grants) here.
# Using IAM or key-pair credentials should be handled by the environment
# stack; this module focuses purely on the account objects.

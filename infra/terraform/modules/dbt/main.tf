terraform {
  required_version = ">= 1.6.0"
}

locals {
  component = "dbt"
  tags = merge(
    var.default_tags,
    {
      component   = local.component
      environment = var.environment
    }
  )
}

# Add resources here to provision dbt Cloud projects, job schedules,
# or infrastructure that executes dbt jobs (for example, ECS tasks or
# Snowflake task definitions). Keep provider-specific configuration in
# this module so environment stacks remain thin.

locals {
  name_prefix = "sovereign-tea-${var.environment}"
}

module "snowflake" {
  source        = "../../modules/snowflake"
  environment   = var.environment
  default_tags  = var.default_tags
  databases     = var.snowflake_databases
  warehouses    = var.snowflake_warehouses
  roles         = var.snowflake_roles
}

module "dagster" {
  source           = "../../modules/dagster"
  environment      = var.environment
  default_tags     = var.default_tags
  network          = var.dagster_network
  image            = var.dagster_image
  postgres         = var.dagster_postgres
  exposed_hostname = var.dagster_hostname
}

module "dbt" {
  source             = "../../modules/dbt"
  environment        = var.environment
  default_tags       = var.default_tags
  execution_platform = var.dbt_execution_platform
  snowflake_role     = var.dbt_role
}

module "airbyte" {
  source        = "../../modules/airbyte"
  environment   = var.environment
  default_tags  = var.default_tags
  workspace     = var.airbyte_workspace
  sources       = var.airbyte_sources
  destinations  = var.airbyte_destinations
  connections   = var.airbyte_connections
}

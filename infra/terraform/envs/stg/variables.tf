variable "environment" {
  description = "Deployment environment identifier."
  type        = string
}

variable "aws_region" {
  description = "AWS region for infrastructure shared by Dagster/Airbyte."
  type        = string
}

variable "default_tags" {
  description = "Tags attached to every resource created in this stack."
  type        = map(string)
  default     = {}
}

variable "snowflake_account" {
  description = "Snowflake account locator (without domain)."
  type        = string
}

variable "snowflake_user" {
  description = "User used by Terraform to manage Snowflake objects."
  type        = string
}

variable "snowflake_password" {
  description = "Password for the Snowflake user."
  type        = string
  sensitive   = true
}

variable "snowflake_role" {
  description = "Role Terraform should assume while managing Snowflake."
  type        = string
}

variable "snowflake_databases" {
  description = "Snowflake databases for this environment."
  type        = list(object({
    name                = string
    comment             = optional(string)
    data_retention_days = optional(number)
  }))
  default = []
}

variable "snowflake_warehouses" {
  description = "Warehouse definitions consumed by dbt/Airbyte workloads."
  type        = list(object({
    name            = string
    size            = string
    auto_suspend    = optional(number, 60)
    auto_resume     = optional(bool, true)
    max_concurrency = optional(number, 4)
  }))
  default = []
}

variable "snowflake_roles" {
  description = "Roles and grants to provision in Snowflake."
  type        = list(object({
    name       = string
    warehouses = optional(list(string), [])
    databases  = optional(list(string), [])
    schemas    = optional(list(string), [])
    comment    = optional(string)
  }))
  default = []
}

variable "dagster_network" {
  description = "Optional networking data (VPC, subnets, security groups)."
  type = object({
    vpc_id     = string
    subnet_ids = list(string)
    sg_ids     = optional(list(string), [])
  })
  default = null
}

variable "dagster_image" {
  description = "Container image tag/URI for Dagster deployments."
  type        = string
  default     = ""
}

variable "dagster_postgres" {
  description = "Connection info for Dagster run/storage database."
  type = object({
    host     = string
    port     = number
    db_name  = string
    username = string
    password = string
  })
}

variable "dagster_hostname" {
  description = "Public hostname (if any) that fronts Dagster UI."
  type        = string
  default     = null
}

variable "dbt_execution_platform" {
  description = "Compute configuration for running dbt jobs."
  type = object({
    type          = string
    image_tag     = optional(string)
    queue_arn     = optional(string)
    schedule_cron = optional(string)
  })
  default = null
}

variable "dbt_role" {
  description = "Snowflake role definition used by dbt."
  type = object({
    name       = string
    warehouses = list(string)
    databases  = list(string)
    privileges = list(string)
  })
  default = null
}

variable "airbyte_host" {
  description = "Base URL for the Airbyte API (OSS or Cloud)."
  type        = string
}

variable "airbyte_api_key" {
  description = "API key used to authenticate with Airbyte."
  type        = string
  sensitive   = true
}

variable "airbyte_workspace" {
  description = "Workspace metadata for Airbyte resources."
  type = object({
    name = string
    id   = optional(string)
  })
}

variable "airbyte_sources" {
  description = "List of source configs (provider-specific settings)."
  type        = list(object({
    name          = string
    definition_id = string
    configuration = map(any)
  }))
  default = []
}

variable "airbyte_destinations" {
  description = "List of destination configs for Airbyte syncs."
  type        = list(object({
    name          = string
    definition_id = string
    configuration = map(any)
  }))
  default = []
}

variable "airbyte_connections" {
  description = "Connection definitions linking sources to destinations."
  type        = list(object({
    name             = string
    source_name      = string
    destination_name = string
    schedule_type    = string
    schedule_data    = map(any)
  }))
  default = []
}

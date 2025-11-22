variable "environment" {
  description = "Short name for the target environment (dev, stg, prod)."
  type        = string
}

variable "default_tags" {
  description = "Default tags for infrastructure shared with dbt workloads."
  type        = map(string)
  default     = {}
}

variable "execution_platform" {
  description = <<DESC
Configuration for where dbt runs. Optionally pass container images, queue names,
or credentials needed by the compute layer (ECS, MWAA, GitHub Actions, etc.).
DESC
  type = object({
    type        = string
    image_tag   = optional(string)
    queue_arn   = optional(string)
    schedule_cron = optional(string)
  })
  default = null
}

variable "snowflake_role" {
  description = "Role name and grants used when dbt connects to Snowflake."
  type = object({
    name        = string
    warehouses  = list(string)
    databases   = list(string)
    privileges  = list(string)
  })
  default = null
}

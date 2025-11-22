variable "environment" {
  description = "Environment tag (dev, stg, prod)."
  type        = string
}

variable "default_tags" {
  description = "Key/value tags stored as Snowflake comments for traceability."
  type        = map(string)
  default     = {}
}

variable "databases" {
  description = "List of Snowflake databases to ensure exist."
  type = list(object({
    name        = string
    comment     = optional(string)
    data_retention_days = optional(number)
  }))
  default = []
}

variable "warehouses" {
  description = "Warehouse definitions consumed by dbt and Airbyte."
  type = list(object({
    name            = string
    size            = string
    auto_suspend    = optional(number, 60)
    auto_resume     = optional(bool, true)
    max_concurrency = optional(number, 4)
  }))
  default = []
}

variable "roles" {
  description = "Roles plus the grants they require (databases, schemas, warehouses)."
  type = list(object({
    name       = string
    warehouses = optional(list(string), [])
    databases  = optional(list(string), [])
    schemas    = optional(list(string), [])
    comment    = optional(string)
  }))
  default = []
}

variable "environment" {
  description = "Short name for the target environment (dev, stg, prod)."
  type        = string
}

variable "default_tags" {
  description = "Tags/labels applied to every Dagster resource."
  type        = map(string)
  default     = {}
}

variable "network" {
  description = <<DESC
Optional network configuration for Dagster workloads (subnets, VPC IDs,
security groups). Leave null when the module should create networking itself.
DESC
  type = object({
    vpc_id     = string
    subnet_ids = list(string)
    sg_ids     = optional(list(string), [])
  })
  default = null
}

variable "image" {
  description = "Container image tag or artifact reference for Dagster deployments."
  type        = string
  default     = ""
}

variable "postgres" {
  description = "Connection info for the Dagster run storage database."
  type = object({
    host     = string
    port     = number
    db_name  = string
    username = string
    password = string
  })
}

variable "exposed_hostname" {
  description = "Optional hostname that should serve the Dagster UI."
  type        = string
  default     = null
}

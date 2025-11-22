variable "environment" {
  description = "Deployment environment label."
  type        = string
}

variable "default_tags" {
  description = "Common tags/labels applied to Airbyte infrastructure."
  type        = map(string)
  default     = {}
}

variable "workspace" {
  description = "Airbyte workspace metadata (name and optional ID)."
  type = object({
    name = string
    id   = optional(string)
  })
}

variable "sources" {
  description = "List of source configurations to seed via the Airbyte API provider."
  type = list(object({
    name         = string
    definition_id = string
    configuration = map(any)
  }))
  default = []
}

variable "destinations" {
  description = "Destination configurations for Airbyte (e.g., Snowflake, S3)."
  type = list(object({
    name          = string
    definition_id = string
    configuration = map(any)
  }))
  default = []
}

variable "connections" {
  description = "Source/destination pairs plus sync settings managed by Terraform."
  type = list(object({
    name            = string
    source_name     = string
    destination_name = string
    schedule_type   = string
    schedule_data   = map(any)
  }))
  default = []
}

output "snowflake_role_name" {
  description = "Role that dbt should assume when running in this environment."
  value       = try(var.snowflake_role.name, null)
}

output "execution_platform" {
  description = "Opaque details about how dbt runs (used by orchestration modules)."
  value       = var.execution_platform
}

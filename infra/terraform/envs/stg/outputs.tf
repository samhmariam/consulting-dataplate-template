output "dagster_ui" {
  description = "Fully qualified URL for the Dagster UI (if exposed)."
  value       = module.dagster.ui_endpoint
}

output "snowflake_warehouses" {
  description = "Warehouses created for this environment."
  value       = module.snowflake.warehouse_names
}

output "airbyte_connections" {
  description = "Number of Airbyte connections under management."
  value       = module.airbyte.connection_count
}

output "ui_endpoint" {
  description = "URL where the Dagster UI is reachable."
  value       = var.exposed_hostname != null ? format("https://%s", var.exposed_hostname) : null
  sensitive   = false
}

output "postgres_connection" {
  description = "Connection details to reuse from other modules (dbt tests, etc.)."
  value       = var.postgres
  sensitive   = true
}

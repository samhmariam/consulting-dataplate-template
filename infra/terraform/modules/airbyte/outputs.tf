output "workspace_name" {
  description = "Workspace managed by this module."
  value       = var.workspace.name
}

output "connection_count" {
  description = "Number of Airbyte connections provisioned via Terraform."
  value       = length(var.connections)
}

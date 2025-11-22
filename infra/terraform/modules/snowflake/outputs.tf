output "database_names" {
  description = "List of databases managed by this module."
  value       = [for db in var.databases : db.name]
}

output "warehouse_names" {
  description = "Warehouses provisioned for downstream consumers."
  value       = [for wh in var.warehouses : wh.name]
}

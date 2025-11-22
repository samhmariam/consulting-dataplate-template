terraform {
  required_version = ">= 1.6.0"
}

locals {
  component = "dagster"
  tags = merge(
    var.default_tags,
    {
      component   = local.component
      environment = var.environment
      managed_by  = "terraform"
    }
  )
}

# TODO: Replace the placeholder locals below with real infrastructure
# resources (ECS/Kubernetes clusters, load balancers, etc.) that will
# host the Dagster code locations and webserver.

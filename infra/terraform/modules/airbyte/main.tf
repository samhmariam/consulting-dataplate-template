terraform {
  required_version = ">= 1.6.0"
}

locals {
  component = "airbyte"
  tags = merge(
    var.default_tags,
    {
      component   = local.component
      environment = var.environment
    }
  )
}

# Define Airbyte deployment resources here (e.g., Kubernetes manifests,
# cloud run services, or the Airbyte OSS Helm chart). Separate modules can
# also use the Airbyte API provider to manage sources/destinations.

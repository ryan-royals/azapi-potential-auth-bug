terraform {
  required_version = ">= 1.3.1"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "1.14.0"
    }
  }
  backend "local" {}
}

provider "azapi" {
  use_msi = var.use_msi
}

resource "azapi_update_resource" "identity_subscription_tags" {
  type                    = "Microsoft.Resources/tags@2021-04-01"
  parent_id               = "/subscriptions/${var.subscription_id}"
  name                    = "default"
  ignore_missing_property = false
  body = jsonencode({
    properties = {
      tags = {
        "azapi"   = "1.14.0"
        "use_msi" = "${var.use_msi}"
      }
    }
  })
}

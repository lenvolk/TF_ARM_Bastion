terraform {
  backend "azurerm" {
  }
}

terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "azurerm" {
  version         = "1.34.0"
  tenant_id       = var.tenant
  subscription_id = var.subscription
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
}
terraform {
  required_providers {
    sysdig = {
      source = "sysdiglabs/sysdig"
    }
  }
}

provider "sysdig" {
  sysdig_secure_url       = "https://app.us4.sysdig.com"
  sysdig_secure_api_token = var.sysdig_api_token
}

provider "azurerm" {
  features { }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret  
}

module "single-subscription" {
  source = "sysdiglabs/secure-for-cloud/azurerm//examples/single-subscription"
}
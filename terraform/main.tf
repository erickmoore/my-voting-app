terraform {
  required_providers {
    sysdig = {
      source = "sysdiglabs/sysdig"
    }
  }
  backend "azurerm" {
      resource_group_name  = "rg-eastus2-sysdig"
      storage_account_name = "sysdigtftest"
      container_name       = "tfstate"
      key                  = "sysdig"
  }  
}

provider "sysdig" {
  sysdig_secure_url       = "https://app.us4.sysdig.com"
  sysdig_secure_api_token = var.sysdig_api_token
}

provider "azurerm" {
  features { }
  subscription_id = "dec16b07-d234-4710-9d31-478e909560fd"
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret  
}

module "tenant-subscriptions" {
  source = "sysdiglabs/secure-for-cloud/azurerm//examples/tenant-subscriptions"
}
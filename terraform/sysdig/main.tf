terraform {
  required_providers {
    sysdig = {
      source = "sysdiglabs/sysdig"
      version = "1.3.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "rg-eastus2-sysdig"
      storage_account_name = "sysdigtftest"
      container_name       = "tfstate"
      key                  = "sysdig-secure"
  }    
}

provider "sysdig" {
  sysdig_secure_url         = "https://app.us4.sysdig.com"
  sysdig_secure_api_token   = var.sysdig_api_token
}

resource "sysdig_secure_policy" "this" {
  
}
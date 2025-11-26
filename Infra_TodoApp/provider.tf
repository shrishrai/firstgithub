terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = "9be859cb-89f5-4725-8795-39770bbb4e7d"
}
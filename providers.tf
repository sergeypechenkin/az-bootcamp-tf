terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.10.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.79"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.1.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false      
    }
  }
}

provider "azapi" {
  # Configuration options
}
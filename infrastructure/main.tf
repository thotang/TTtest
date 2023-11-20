terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.81"
    }
  }
   backend "azurerm" {
    resource_group_name  = "tf-state-test-rg"
    storage_account_name = "tfstatetestsa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  }

locals {
  tags = {
    "source"       = "Terraform"
    "organization" = "Tv-aksjonen"
    "businessUnit" = "Tv-aksjonen nettbutikk"   
    "application"  = "tv-aksjonen-butikk"
    "environment"  = var.environment
  }  
}

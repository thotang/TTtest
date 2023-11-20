terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.51"
    }
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

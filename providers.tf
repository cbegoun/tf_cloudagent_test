terraform {
  required_version = ">= 1.0.0"
  cloud {
    organization = "test_terraform_cbegoun"
    workspaces {
      name = "tf_cloudagent_test"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.12.0"
    }

  }
}

provider "azurerm" {
  features {}
}


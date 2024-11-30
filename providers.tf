terraform {

  cloud {
    organization = "test_terraform_cbegoun"
    workspaces {
      name = "tf_cloudagent_testt"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }
}

provider "azurerm" {
  features {}
}


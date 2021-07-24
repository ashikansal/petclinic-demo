provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = var.master_rg
    storage_account_name = var.master_sa
    container_name = "tfstate"
    key = "petclinic.tfstate"
  }
}
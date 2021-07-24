provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "ash-master-rg"
    storage_account_name = "tf0state0sa"
    container_name = "tfstate"
    key = "petclinic.tfstate"
  }
}
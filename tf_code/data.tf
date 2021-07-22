data "azurerm_image" "app-rest-image" {
  name = "petclinic-rest"
  resource_group_name = "ash-master-rg"
}
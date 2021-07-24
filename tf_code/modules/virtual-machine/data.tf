data "azurerm_image" "image" {
  name = var.image_name
  resource_group_name = var.image_resource_group
}

data "azurerm_subnet" "subnet" {
  name = var.subnet
  virtual_network_name = var.vnet
  resource_group_name = var.resource_group
}
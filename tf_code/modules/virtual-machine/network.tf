//resource "azurerm_public_ip" "pip" {
//  allocation_method = "Static"
//  location = var.location
//  name = "${var.vm_name}-pip"
//  resource_group_name = var.resource_group
//}

resource "azurerm_network_interface" "nic" {
  location = var.location
  name = "${var.vm_name}-nic"
  resource_group_name = var.resource_group
  ip_configuration {
    name = "${var.vm_name}-ip-conf"
    private_ip_address_allocation = "Dynamic"
    subnet_id = var.subnet_id
//    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "lb-backend" {
  count = var.enable_lb_association ? 1 : 0
  backend_address_pool_id = var.lb_backend_pool_id
  ip_configuration_name = azurerm_network_interface.nic.ip_configuration[0].name
  network_interface_id = azurerm_network_interface.nic.id
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id = azurerm_network_interface.nic.id
  network_security_group_id = var.nsg_id
}
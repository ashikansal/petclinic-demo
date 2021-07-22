resource "azurerm_linux_virtual_machine" "app_vm" {
  name = var.vm_name
  resource_group_name = var.resource_group
  location = var.location
  size = var.image_size
  admin_username = var.vm_username
  admin_password = var.vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_id = data.azurerm_image.image.id
  custom_data = var.custom_data
}
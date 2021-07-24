resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "app_vm" {
  name = var.vm_name
  resource_group_name = var.resource_group
  location = var.location
  size = var.image_size
  admin_username = var.vm_username
  admin_ssh_key {
    public_key = tls_private_key.private_key.public_key_openssh
    username = var.vm_username
  }
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
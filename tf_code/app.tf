//locals {
//  frontend_custom_data = <<CUSTOM_DATA
//  #!/bin/bash
//  echo "Execute your super awesome commands here!"
//  sudo sed -i "s/localhost:9966/${module.rest-app-vm.vm_public_ip}:9966/g" /opt/spring-petclinic-angular/src/environments/*.ts
//  CUSTOM_DATA
//}

module "rest-app-vm" {
  source = "./modules/virtual-machine"
  count = 2
  resource_group = azurerm_resource_group.demo_rg.name
  vnet = azurerm_virtual_network.app-vnet.name
  subnet = "${var.subnets[0].name}-subnet"
  vm_name = "${var.rest_vm_name}-${count.index + 1}"
  vm_username = var.vm_username
  image_name = var.rest_image
  lb_backend_pool_id = module.rest-lb.lb_backend_pool_id
  depends_on = [azurerm_virtual_network.app-vnet]
}

module "frontend-app-vm" {
  source = "./modules/virtual-machine"
  count = 2
  resource_group = azurerm_resource_group.demo_rg.name
  vnet = azurerm_virtual_network.app-vnet.name
  subnet = "${var.subnets[1].name}-subnet"
  vm_name = "${var.frontend_vm_name}-${count.index + 1}"
  vm_username = var.vm_username
  image_name = var.frontend_image
  lb_backend_pool_id = module.frontend-lb.lb_backend_pool_id
  depends_on = [azurerm_virtual_network.app-vnet]
//  custom_data = base64encode(local.frontend_custom_data)
}

module "db-app-vm" {
  source = "./modules/virtual-machine"
  count = 1
  resource_group = azurerm_resource_group.demo_rg.name
  vnet = azurerm_virtual_network.app-vnet.name
  subnet = "${var.subnets[2].name}-subnet"
  vm_name = "${var.db_vm_name}-${count.index + 1}"
  vm_username = var.vm_username
  image_name = var.db_image
  enable_lb_association = false
  depends_on = [azurerm_virtual_network.app-vnet]
  //  custom_data = base64encode(local.frontend_custom_data)
}
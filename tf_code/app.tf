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
  subnet = var.subnets[0].name
  vm_name = "rest-app-${count.index + 1}"
  vm_username = "petclinic"
  vm_password = "pet@RESTapp"
  image_name = "petclinic-rest"
  lb_backend_pool_id = module.rest-lb.lb_backend_pool_id
  nsg_id = azurerm_network_security_group.rest_subnet_nsg.id
  depends_on = [azurerm_virtual_network.app-vnet]
}

module "frontend-app-vm" {
  source = "./modules/virtual-machine"
  count = 2
  resource_group = azurerm_resource_group.demo_rg.name
  vnet = azurerm_virtual_network.app-vnet.name
  subnet = var.subnets[1].name
  vm_name = "frontend-app-${count.index + 1}"
  vm_username = "petclinic"
  vm_password = "pet@FRONTapp"
  image_name = "petclinic-frontend"
  lb_backend_pool_id = module.frontend-lb.lb_backend_pool_id
  nsg_id = azurerm_network_security_group.frontend_subnet_nsg.id
  depends_on = [azurerm_virtual_network.app-vnet]
//  custom_data = base64encode(local.frontend_custom_data)
}

module "db-app-vm" {
  source = "./modules/virtual-machine"
  count = 1
  resource_group = azurerm_resource_group.demo_rg.name
  vnet = azurerm_virtual_network.app-vnet.name
  subnet = var.subnets[2].name
  vm_name = "db-app-${count.index + 1}"
  vm_username = "petclinic"
  vm_password = "pet@DBapp"
  image_name = "petclinic-database"
  nsg_id = azurerm_network_security_group.db_subnet_nsg.id
  enable_lb_association = false
  depends_on = [azurerm_virtual_network.app-vnet]
  //  custom_data = base64encode(local.frontend_custom_data)
}
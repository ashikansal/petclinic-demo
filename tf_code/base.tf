resource "azurerm_resource_group" "demo_rg" {
  name = var.resource_group
  location = var.location
}

resource "azurerm_virtual_network" "app-vnet" {
  address_space = [var.vnet_addr]
  location = var.location
  name = var.vnet_name
  resource_group_name = azurerm_resource_group.demo_rg.name
  dynamic "subnet" {
    for_each = var.subnets
    content {
      address_prefix = cidrsubnet(var.vnet_addr, 8, subnet.value.number )
      name = subnet.value.name
    }
  }
}

//resource "azurerm_subnet" "bastion-subnet" {
//  name = "AzureBastionSubnet"
//  resource_group_name = azurerm_resource_group.demo_rg.name
//  virtual_network_name = azurerm_virtual_network.app-vnet.name
//  address_prefixes = ["10.4.4.0/27"]
//}

//resource "azurerm_public_ip" "bastion-ip" {
//  allocation_method = "Static"
//  location = var.location
//  name = "bastion-pip"
//  resource_group_name = azurerm_resource_group.demo_rg.name
//  sku = "Standard"
//}

//resource "azurerm_bastion_host" "bastion" {
//  location = var.location
//  name = "petclinic-bastion"
//  resource_group_name = azurerm_resource_group.demo_rg.name
//  ip_configuration {
//    name = "bastion-ip-conf"
//    public_ip_address_id = azurerm_public_ip.bastion-ip.id
//    subnet_id = azurerm_subnet.bastion-subnet.id
//  }
//}

//resource "azurerm_network_security_group" "" {
//  for_each = var.nsg_rules
//  location = var.location
//  name = each.key
//  resource_group_name = azurerm_resource_group.demo_rg.name
//  dynamic "security_rule" {
//    for_each = each.value
//    iterator = rule
//    content {
//      access = "Allow"
//      direction = "Inbound"
//      name = ""
//      priority = rule.value.priority
//      protocol = rule.value.protocol
//    }
//  }
//}
resource "azurerm_network_security_group" "rest_subnet_nsg" {
  location = var.location
  name = "petclinic-rest-nsg"
  resource_group_name = azurerm_resource_group.demo_rg.name
  security_rule {
    access = "Allow"
    direction = "Inbound"
    name = "Allow_9966"
    priority = 101
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "9966"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "frontend_subnet_nsg" {
  location = var.location
  name = "petclinic-frontend-nsg"
  resource_group_name = azurerm_resource_group.demo_rg.name
  security_rule {
    access = "Allow"
    direction = "Inbound"
    name = "Allow_4200"
    priority = 101
    protocol = "tcp"
    source_port_range = "*"
    destination_port_range = "4200"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "db_subnet_nsg" {
  location = var.location
  name = "petclinic-db-nsg"
  resource_group_name = azurerm_resource_group.demo_rg.name
  security_rule {
    access = "Allow"
    direction = "Inbound"
    name = "Allow_5432"
    priority = 101
    protocol = "tcp"
    source_port_range = "*"
    destination_port_range = "5432"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}
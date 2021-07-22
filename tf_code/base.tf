resource "azurerm_resource_group" "demo_rg" {
  name = "petclinic-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "app-vnet" {
  address_space = ["10.4.0.0/16"]
  location = "eastus"
  name = "petclinic-vnet"
  resource_group_name = azurerm_resource_group.demo_rg.name
}

resource "azurerm_subnet" "rest-subnet" {
  name = "petclinic-rest-subnet"
  resource_group_name = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.app-vnet.name
  address_prefixes = ["10.4.1.0/24"]
}

resource "azurerm_subnet" "frontend-subnet" {
  name = "petclinic-frontend-subnet"
  resource_group_name = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.app-vnet.name
  address_prefixes = ["10.4.2.0/24"]
}

resource "azurerm_subnet" "db-subnet" {
  name = "petclinic-db-subnet"
  resource_group_name = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.app-vnet.name
  address_prefixes = ["10.4.3.0/24"]
}

resource "azurerm_subnet" "bastion-subnet" {
  name = "AzureBastionSubnet"
  resource_group_name = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.app-vnet.name
  address_prefixes = ["10.4.4.0/27"]
}

resource "azurerm_public_ip" "bastion-ip" {
  allocation_method = "Static"
  location = "eastus"
  name = "bastion-pip"
  resource_group_name = azurerm_resource_group.demo_rg.name
  sku = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  location = "eastus"
  name = "petclinic-bastion"
  resource_group_name = azurerm_resource_group.demo_rg.name
  ip_configuration {
    name = "bastion-ip-conf"
    public_ip_address_id = azurerm_public_ip.bastion-ip.id
    subnet_id = azurerm_subnet.bastion-subnet.id
  }
}

resource "azurerm_network_security_group" "rest_subnet_nsg" {
  location = "eastus"
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
  location = "eastus"
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
  location = "eastus"
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
resource "azurerm_resource_group" "demo_rg" {
  name = var.resource_group
  location = var.location
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg_rules
  location = var.location
  name = "${each.key}-nsg"
  resource_group_name = azurerm_resource_group.demo_rg.name
  dynamic "security_rule" {
    for_each = each.value
    iterator = rule
    content {
      access = "Allow"
      direction = "Inbound"
      name = "Allow_${rule.value.destination_port_range}"
      priority = rule.value.priority
      protocol = rule.value.protocol
      source_port_range = rule.value.source_port_range
      destination_port_range = rule.value.destination_port_range
      source_address_prefix = rule.value.source_address_prefix
      destination_address_prefix = rule.value.destination_address_prefix
    }
  }
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
      name = "${subnet.value.name}-subnet"
      security_group = azurerm_network_security_group.nsg[subnet.value.name].id
    }
  }
}
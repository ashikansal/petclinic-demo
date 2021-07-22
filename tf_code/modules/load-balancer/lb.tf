resource "azurerm_public_ip" "lb_pip" {
  allocation_method = "Static"
  location = var.location
  name = var.lb_pip_name
  resource_group_name = var.rg_name
  sku = "Standard"
  domain_name_label = var.dns_name
}

resource "azurerm_lb" "app-lb" {
  location = var.location
  name = var.lb_name
  resource_group_name = var.rg_name
  frontend_ip_configuration {
    name = "${var.lb_name}-ip-conf"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
  sku = "Standard"
}

resource "azurerm_lb_backend_address_pool" "lb-pool" {
  loadbalancer_id = azurerm_lb.app-lb.id
  name = "${var.lb_name}-BackendPool"
  resource_group_name = var.rg_name
}

resource "azurerm_lb_probe" "lb-probe" {
  loadbalancer_id = azurerm_lb.app-lb.id
  name = "${var.lb_name}-health-probe"
  port = var.lb_probe_port
  protocol = "Http"
  request_path = var.lb_probe_path
  resource_group_name = var.rg_name
}

resource "azurerm_lb_rule" "lb-rule" {
  backend_port = var.lb_backend_port
  frontend_ip_configuration_name = azurerm_lb.app-lb.frontend_ip_configuration[0].name
  frontend_port = var.lb_frontend_port
  loadbalancer_id = azurerm_lb.app-lb.id
  name = "${var.lb_name}-rule"
  protocol = var.protocol
  resource_group_name = var.rg_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-pool.id
  probe_id = azurerm_lb_probe.lb-probe.id
}
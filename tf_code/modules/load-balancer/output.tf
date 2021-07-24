output "lb_backend_pool_id" {
  value = azurerm_lb_backend_address_pool.lb-pool.id
}

output "lb_ip" {
  value = azurerm_public_ip.lb_pip.ip_address
}
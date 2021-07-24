module "rest-lb" {
  source = "./modules/load-balancer"
  location = var.location
  lb_pip_name = "Rest-app-PIP"
  lb_name = "petclinic-rest-lb"
  rg_name = azurerm_resource_group.demo_rg.name
  lb_frontend_port = var.lb["rest"]["port"]
  lb_backend_port = var.lb["rest"]["port"]
  protocol = var.lb["rest"]["protocol"]
  lb_probe_port = var.lb["rest"]["port"]
  lb_probe_path = var.lb["rest"]["probe_path"]
  dns_name = var.lb["rest"]["dns_name"]

}

module "frontend-lb" {
  source = "./modules/load-balancer"
  location = var.location
  lb_pip_name = "Frontend-app-PIP"
  lb_name = "petclinic-frontend-lb"
  rg_name = azurerm_resource_group.demo_rg.name
  lb_frontend_port = var.lb["frontend"]["port"]
  lb_backend_port = var.lb["frontend"]["port"]
  protocol = var.lb["frontend"]["protocol"]
  lb_probe_port = var.lb["frontend"]["port"]
  lb_probe_path = var.lb["frontend"]["probe_path"]
}
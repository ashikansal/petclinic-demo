module "rest-lb" {
  source = "./modules/load-balancer"
  location = "eastus"
  lb_pip_name = "Rest-app-PIP"
  lb_name = "petclinic-rest-lb"
  rg_name = azurerm_resource_group.demo_rg.name
  lb_frontend_port = "9966"
  lb_backend_port = "9966"
  protocol = "TCP"
  lb_probe_port = "9966"
  lb_probe_path = "petclinic/actuator/health"
  dns_name = "petclinic-rest-dev"

}

module "frontend-lb" {
  source = "./modules/load-balancer"
  location = "eastus"
  lb_pip_name = "Frontend-app-PIP"
  lb_name = "petclinic-frontend-lb"
  rg_name = azurerm_resource_group.demo_rg.name
  lb_frontend_port = "4200"
  lb_backend_port = "4200"
  protocol = "TCP"
  lb_probe_port = "4200"
  lb_probe_path = "/"
}
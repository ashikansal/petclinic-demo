variable "location" {}

variable "lb_pip_name" {}

variable "lb_name" {}

variable "rg_name" {}

variable "subnet_id" {}

variable "lb_frontend_port" {}

variable "lb_backend_port" {}

variable "protocol" {}

variable "lb_probe_port" {}

variable "lb_probe_path" {}

variable "dns_name" {
  default = null
}

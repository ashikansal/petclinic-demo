variable "location" {
  default = "eastus"
}

variable "resource_group" {
  default = "petclinic-rg"
}

variable "image_resource_group" {
  default = "ash-master-rg"
}

variable "vnet" {
}

variable "subnet_id" {
}

variable "vm_name" {
}

variable "image_name" {
}

variable "image_size" {
  default = "Standard_D2s_v3"
}

variable "vm_username" {
}

variable "vm_password" {
}

variable "custom_data" {
  default = null
}

variable "lb_backend_pool_id" {
  default = null
}

variable "nsg_id" {}

variable "enable_lb_association" {
  type = bool
  default = true
}
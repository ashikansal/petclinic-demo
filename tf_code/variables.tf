variable "resource_group" {}
variable "location" {}
variable "subnets" {
  type = list(object(
    {
      name = string,
      number = number
    }))
}
variable "vnet_name" {}
variable "vnet_addr" {}
variable "nsg_rules" {
}
variable "rest_image" {}
variable "frontend_image" {}
variable "db_image" {}
variable "rest_vm_name" {}
variable "frontend_vm_name" {}
variable "db_vm_name" {}
variable "vm_username" {}
variable "lb" {
  type = map(object(
    {
      port = string,
      probe_path = string,
      protocol = string,
      dns_name = string
    }))
}
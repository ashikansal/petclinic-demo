variable "resource_group" {}
variable "location" {}
variable "subnets" {
  type = list(object({name = string, number = number}))
}
variable "vnet_name" {}
variable "vnet_addr" {}
variable "nsg_rules" {}


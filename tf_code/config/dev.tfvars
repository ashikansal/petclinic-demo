master_rg = "ash-master-rg"
master_sa = "tf0state0sa"
resource_group = "petclinic-rg"
location = "eastus"
vnet_name = "petclinic-vnet"
vnet_addr = "10.4.0.0/16"
subnets = [
  {
    name = "rest"
    number = 1
  },
  { name = "frontend"
    number = 2
  },
  { name = "db"
    number = 3
  }
]

nsg_rules = {
    rest = [
      {
        priority = 101
        protocol = "TCP"
        source_port_range = "*"
        destination_port_range = "9966"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    ],
    frontend = [
      {
        priority = 101
        protocol = "TCP"
        source_port_range = "*"
        destination_port_range = "4200"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    ],
    db = [
      {
        priority = 101
        protocol = "TCP"
        source_port_range = "*"
        destination_port_range = "5432"
        source_address_prefix = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      }
    ]
}

rest_image = "petclinic-rest"
frontend_image = "petclinic-frontend"
db_image = "petclinic-database"
rest_vm_name = "rest-app"
frontend_vm_name = "frontend-app"
db_vm_name = "db-app"
vm_username = "petclinic"

lb = {
  frontend = {
    port = "4200"
    probe_path = "petclinic/actuator/health"
    protocol = "TCP"
    dns_name = null
  },
  rest = {
    port = "9966"
    probe_path = "/"
    protocol = "TCP"
    dns_name = "petclinic-rest-dev"
  }
}

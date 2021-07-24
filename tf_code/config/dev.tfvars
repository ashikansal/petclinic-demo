resource_group = "petclinic-rg"
location = "eastus"
vnet_name = "petclinic-vnet"
vnet_addr = "10.4.0.0/16"
subnets = [
  {
    name = "petclinic-rest-subnet"
    number = 1
  },
  { name = "petclinic-frontend-subnet"
    number = 2
  },
  { name = "petclinic-db-subnet"
    number = 3
  }
]

//subnets_new = {
//  rest = {
//    name = "petclinic-rest-subnet"
//    number = 1
//  },
//  frontend = {
//    name = "petclinic-frontend-subnet"
//    number = 2
//  },
//  db = {
//    name = "petclinic-db-subnet"
//    number = 3
//  }
//}

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
    front = [
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
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    ]
  }
resource_group_name = "rg-prod"

location = "Central India"

vnet_name = "prod-vnet"

address_space = [
  "10.0.0.0/16"
]

dns_servers = [
  "8.8.8.8",
  "8.8.4.4"
]

tags = {
  Environment = "Prod"
}

subnets = {

  aks = {

    address_prefixes = [
      "10.0.1.0/24"
    ]

  }

}
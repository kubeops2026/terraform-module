rgvar-p ={
    RG1 = {
        resource-group-name = "prod-india-rg1"
        location = "eastus"
    }
}

vnet_p = {

    vnet01 = {

    name                = "vnet-prod"
    location            = "East US"
    resource_group_name = "rg-network-prod"

    address_space = ["10.0.0.0/16"]

    dns_servers = ["10.0.0.4"]

    tags = {
      env = "prod"
    }
  }
}  

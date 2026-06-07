resource "azurerm_virtual_network" "vnet" {

  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = var.address_space
  dns_servers   = var.dns_servers

  dynamic "ddos_protection_plan" {

    for_each = var.ddos_protection_plan_id != null ? [1] : []

    content {
      id     = var.ddos_protection_plan_id
      enable = true
    }
  }

  tags = var.tags
}

resource "azurerm_subnet" "subnet" {

  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = each.value.address_prefixes

  service_endpoints = try(
    each.value.service_endpoints,
    null
  )

  private_endpoint_network_policies = try(
    each.value.private_endpoint_network_policies,
    null
  )

  dynamic "delegation" {

    for_each = try(each.value.delegation, null) != null ? [each.value.delegation] : []

    content {

      name = delegation.value.name

      service_delegation {

        name = delegation.value.service_delegation.name

        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

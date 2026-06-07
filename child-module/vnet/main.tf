resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnet_var

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  address_space = each.value.address_space
  dns_servers   = each.value.dns_servers

  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes

  tags = each.value.tags
}
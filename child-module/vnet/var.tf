variable "vnet_var" {
  description = "Map of VNets"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)

    dns_servers             = optional(list(string), [])
    flow_timeout_in_minutes = optional(number)
    tags                    = optional(map(string), {})
  }))
}
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "dns_servers" {
  type    = list(string)
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ddos_protection_plan_id" {
  type    = string
  default = null
}

variable "subnets" {

  type = map(object({

    address_prefixes = list(string)

    service_endpoints = optional(list(string))

    private_endpoint_network_policies = optional(string)

    private_link_service_network_policies_enabled = optional(bool)

    nsg_id = optional(string)

    delegation = optional(object({
      name = string

      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))

  default = {}
}

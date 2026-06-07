variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network Name"
  type        = string
}

variable "address_space" {
  description = "VNet CIDR Blocks"
  type        = list(string)
}

variable "dns_servers" {
  description = "Custom DNS Servers"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "bgp_community" {
  type    = string
  default = null
}

variable "edge_zone" {
  type    = string
  default = null
}

variable "ddos_protection_plan_id" {
  type    = string
  default = null
}

variable "subnets" {

  description = "Subnet Configuration"

  type = map(object({

    address_prefixes = list(string)

    service_endpoints = optional(list(string))

    service_endpoint_policy_ids = optional(list(string))

    private_endpoint_network_policies_enabled = optional(bool)

    private_link_service_network_policies_enabled = optional(bool)

    default_outbound_access_enabled = optional(bool)

    delegation = optional(object({

      name = string

      service_delegation = object({

        name    = string
        actions = list(string)

      })
    }))

    nsg_id = optional(string)

    route_table_id = optional(string)

  }))

  default = {}
}
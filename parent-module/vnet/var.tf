variable "resource_group_name" {
  description = "Name of the Azure Resource Group where resources will be deployed."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
}

variable "address_space" {
  description = "List of address spaces for the Virtual Network."
  type        = list(string)
}

variable "dns_servers" {
  description = "List of DNS server IP addresses for the Virtual Network."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Map of subnet configurations."
  type = map(object({
    address_prefixes = list(string)
  }))
}

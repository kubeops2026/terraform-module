variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "dns_prefix" {
  type = string
}

variable "sku_tier" {
  type    = string
  default = "Standard"
}

variable "private_cluster_enabled" {
  type    = bool
  default = false
}

variable "oidc_issuer_enabled" {
  type    = bool
  default = true
}

variable "workload_identity_enabled" {
  type    = bool
  default = true
}

variable "azure_policy_enabled" {
  type    = bool
  default = false
}

variable "local_account_disabled" {
  type    = bool
  default = true
}

variable "automatic_upgrade_channel" {
  type    = string
  default = "patch"
}

variable "authorized_ip_ranges" {
  type    = list(string)
  default = []
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })

  default = {
    type = "SystemAssigned"
  }
}

variable "default_node_pool" {

  type = object({
    name                  = string
    vm_size               = string
    node_count            = optional(number)
    min_count             = optional(number)
    max_count             = optional(number)
    enable_auto_scaling   = bool
    os_disk_size_gb       = optional(number)
    zones                 = optional(list(string))
    max_pods              = optional(number)
    only_critical_addons_enabled = optional(bool)
  })
}

variable "network_profile" {

  type = object({
    network_plugin      = string
    network_policy      = optional(string)
    dns_service_ip      = string
    service_cidr        = string
    load_balancer_sku   = string
    outbound_type       = string
  })
}

variable "log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "enable_defender" {
  type    = bool
  default = false
}

variable "enable_keyvault_csi" {
  type    = bool
  default = true
}

variable "node_pools" {

  type = map(object({
    vm_size             = string
    node_count          = optional(number)
    min_count           = optional(number)
    max_count           = optional(number)
    enable_auto_scaling = bool
    mode                = optional(string, "User")
    zones               = optional(list(string))
    node_labels         = optional(map(string))
    node_taints         = optional(list(string))
  }))

  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "diagnostic_settings" {
  type = object({
    enabled                        = bool
    log_analytics_workspace_id     = optional(string)
    storage_account_id             = optional(string)
    eventhub_authorization_rule_id = optional(string)
    eventhub_name                  = optional(string)
  })

  default = {
    enabled = false
  }
}

variable "private_dns_zone_id" {
  type    = string
  default = null
}
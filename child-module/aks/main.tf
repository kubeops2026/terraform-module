# AKS module-
resource "azurerm_kubernetes_cluster" "aks" {

  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = var.dns_prefix

  kubernetes_version = var.kubernetes_version

  sku_tier = var.sku_tier


  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled

  local_account_disabled = var.local_account_disabled

  automatic_upgrade_channel = var.automatic_upgrade_channel

  azure_policy_enabled = var.azure_policy_enabled
  private_cluster_enabled = var.private_cluster_enabled

  private_dns_zone_id = var.private_cluster_enabled ? (
  var.private_dns_zone_id
   ) : null

  default_node_pool {

    name       = var.default_node_pool.name
    vm_size    = var.default_node_pool.vm_size

    node_count = try(var.default_node_pool.node_count, null)

    auto_scaling_enabled = var.default_node_pool.enable_auto_scaling

    min_count = try(var.default_node_pool.min_count, null)
    max_count = try(var.default_node_pool.max_count, null)

    os_disk_size_gb = try(var.default_node_pool.os_disk_size_gb, null)

    max_pods = try(var.default_node_pool.max_pods, null)

    zones = try(var.default_node_pool.zones, null)

    only_critical_addons_enabled = try(
      var.default_node_pool.only_critical_addons_enabled,
      null
    )
  }

  identity {

    type = var.identity.type

    identity_ids = try(
      var.identity.identity_ids,
      null
    )
  }

  network_profile {

    network_plugin = var.network_profile.network_plugin

    network_policy = try(
      var.network_profile.network_policy,
      null
    )

    dns_service_ip = var.network_profile.dns_service_ip

    service_cidr = var.network_profile.service_cidr

    load_balancer_sku = var.network_profile.load_balancer_sku

    outbound_type = var.network_profile.outbound_type
  }

  dynamic "oms_agent" {

    for_each = var.log_analytics_workspace_id != null ? [1] : []

    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  dynamic "microsoft_defender" {

    for_each = var.enable_defender ? [1] : []

    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  dynamic "key_vault_secrets_provider" {

    for_each = var.enable_keyvault_csi ? [1] : []

    content {
      secret_rotation_enabled = true
    }
  }

  dynamic "api_server_access_profile" {

    for_each = length(var.authorized_ip_ranges) > 0 ? [1] : []

    content {
      authorized_ip_ranges = var.authorized_ip_ranges
    }
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "pool" {

  for_each = var.node_pools

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id

  vm_size = each.value.vm_size

  mode = try(each.value.mode, "User")

  auto_scaling_enabled = each.value. auto_scaling_enabled

  node_count = try(each.value.node_count, null)

  min_count = try(each.value.min_count, null)

  max_count = try(each.value.max_count, null)

  zones = try(each.value.zones, null)

  node_labels = try(each.value.node_labels, null)

  node_taints = try(each.value.node_taints, null)

  lifecycle {
    ignore_changes = [
      node_count
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "aks" {

  count = var.diagnostic_settings.enabled ? 1 : 0

  name                       = "${var.cluster_name}-diag"
  target_resource_id         = azurerm_kubernetes_cluster.aks.id

  log_analytics_workspace_id = try(
    var.diagnostic_settings.log_analytics_workspace_id,
    null
  )

  storage_account_id = try(
    var.diagnostic_settings.storage_account_id,
    null
  )

  eventhub_authorization_rule_id = try(
    var.diagnostic_settings.eventhub_authorization_rule_id,
    null
  )

  eventhub_name = try(
    var.diagnostic_settings.eventhub_name,
    null
  )

  enabled_log {
    category = "kube-apiserver"
  }

  enabled_log {
    category = "kube-audit"
  }

  enabled_log {
    category = "kube-audit-admin"
  }

  enabled_log {
    category = "kube-controller-manager"
  }

  enabled_log {
    category = "kube-scheduler"
  }

  enabled_log {
    category = "cluster-autoscaler"
  }

  enabled_log {
    category = "guard"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

module "aks" {
    source = "../../child-module/aks"
    resource_group_name = var.resource_group_name
    location            = var.location
    cluster_name        = var.cluster_name
    kubernetes_version  = var.kubernetes_version
    dns_prefix          = var.dns_prefix
    sku_tier            = var.sku_tier
    private_cluster_enabled = var.private_cluster_enabled
    oidc_issuer_enabled = var.oidc_issuer_enabled
    workload_identity_enabled = var.workload_identity_enabled
    azure_policy_enabled      = var.azure_policy_enabled
    local_account_disabled    = var.local_account_disabled
    automatic_upgrade_channel = var.automatic_upgrade_channel
    authorized_ip_ranges      = var.authorized_ip_ranges
    identity                  = var.identity
    default_node_pool         = var.default_node_pool
    network_profile           = var.network_profile
    log_analytics_workspace_id = var.log_analytics_workspace_id
    enable_defender            = var.enable_defender
    enable_keyvault_csi        = var.enable_keyvault_csi
    node_pools                 = var.node_pools
    tags                       = var.tags
    private_dns_zone_id        = var.private_dns_zone_id
    diagnostic_settings        = var.diagnostic_settings

}
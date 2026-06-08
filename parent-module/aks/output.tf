output "aks_id" {
  value = module.aks.aks_id
}

output "aks_name" {
  value = module.aks.aks_name
}

output "kube_config" {
  value     = module.aks.kube_config
}

output "oidc_issuer_url" {
  value = module.aks.oidc_issuer_url
}

output "node_resource_group" {
  value = module.aks.node_resource_group
}

output "principal_id" {
  value = module.aks.principal_id
}
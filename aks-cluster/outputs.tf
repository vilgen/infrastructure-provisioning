output "aks_kube_config" {
  description = "Kube config"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "aks_fqdn" {
  description = "AKS cluster API server FQDN"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}
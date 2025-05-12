output "acr_login_server" {
  description = "ACR Login Server"
  value       = azurerm_container_registry.acr.login_server
}

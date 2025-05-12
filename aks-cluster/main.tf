terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "ewp-vnet"
  address_space       = ["10.0.0.0/8"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create Subnet for AKS
resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.240.0.0/16"]
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
    dns_service_ip     = "10.2.0.10"
    service_cidr       = "10.2.0.0/24"
    #docker_bridge_cidr = "172.17.0.1/16"
  }

  role_based_access_control_enabled = true
  kubernetes_version = var.kubernetes_version
}

# Optional System Node Pool
# resource "azurerm_kubernetes_cluster_node_pool" "system_pool" {
#   name                  = "systemnp"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#   vm_size               = "Standard_B1ms"
#   node_count            = 1
#   os_type               = "Linux"
#   mode                  = "System"
#   vnet_subnet_id        = azurerm_subnet.aks_subnet.id
# }

# ACR module
module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  principal_id        = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
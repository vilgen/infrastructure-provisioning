variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "ewp-resources"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "eastus"
}

variable "cluster_name" {
  description = "AKS Cluster name"
  type        = string
  default     = "ewp-aks-cluster"
}

variable "dns_prefix" {
  description = "DNS prefix"
  type        = string
  default     = "ewp-aks"
}

variable "node_count" {
  description = "Number of nodes in default pool"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "VM size for default and system pools"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
  default     = "1.29.2"
}
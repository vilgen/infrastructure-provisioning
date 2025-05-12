variable "acr_name" {
  description = "ACR name (globally unique)"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

variable "principal_id" {
  description = "Principal ID (object ID) of AKS kubelet identity"
  type        = string
}

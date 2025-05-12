# infrastructure-provisioning
Infrastructure Provisioning playground for cloud providers

# AKS
# 🚀 AKS Cluster Deployment on Azure using Terraform

This project provisions an Azure Kubernetes Service (AKS) cluster with a custom virtual network and a dedicated system node pool using Terraform.

---

## 📦 Prerequisites

Make sure you have the following installed:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure subscription

---

## ⚙️ Configuration

You can customize the default values in:

- `variables.tf` – for default inputs
- `terraform.tfvars` – for overriding variables

---

## 🚀 Deployment Steps

Follow the steps below to deploy your AKS infrastructure:

### 1. Authenticate with Azure:

```bash
az login
```
### 2. Provision Infra with terraform CLI:
```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

After deployment, Terraform will output:

The AKS kubeconfig content (aks_kube_config)

The AKS control plane FQDN (aks_fqdn)

You can save the kubeconfig like this:

```bash
terraform output -raw aks_kube_config > kubeconfig.yaml
export KUBECONFIG=$(pwd)/kubeconfig.yaml
kubectl get nodes
```

### 3. Destroy Infra:

```bash
terraform destroy
```
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


## 📦 Ansible Setup and Usage
This project uses Ansible to deploy workloads (like NGINX) to the AKS cluster provisioned by Terraform.

✅ Prerequisites

Terraform provisioning completed

AKS cluster is running

kubeconfig.yaml exported from Terraform output

🔧 Install Ansible (macOS)
```bash
brew install ansible
```
Check version:

```bash
ansible --version
```
📥 Install Kubernetes Collection

The Ansible playbook uses the kubernetes.core collection.

Install it using:

```bash
ansible-galaxy collection install kubernetes.core
```

📄 Prepare Kubeconfig

Export the kubeconfig from Terraform output and set the environment variable:

```bash
terraform output -raw aks_kube_config > kubeconfig.yaml
export KUBECONFIG=$(pwd)/kubeconfig.yaml
```

Alternatively, you can hardcode the path inside the Ansible playbook.

▶️ Run Ansible Playbook
Deploy NGINX to the AKS cluster:

```bash
ansible-playbook deploy-nginx.yaml
```

This will:

- Create a Deployment named nginx

- Create a Service of type LoadBalancer to expose it

🌐 Access the NGINX Endpoint
Check the external IP:

```bash
kubectl get svc nginx-service
```

Then open the service in your browser:

```bash
http://<EXTERNAL-IP>
```
Or test via curl:

```bash
curl http://<EXTERNAL-IP>
```

## 🚀 Argo CD Setup on AKS (via Ansible)

This playbook installs Argo CD in your AKS cluster using Ansible and configures it for external access via LoadBalancer.

---

## 📦 Prerequisites

- A running AKS cluster (deployed via Terraform)
- `kubectl` configured with access (`kubeconfig.yaml`)
- `ansible` installed with the `kubernetes.core` collection:

```bash
ansible-galaxy collection install kubernetes.core
```

Run the playbook:
```bash
ansible-playbook install-argocd.yaml
```

### 🌐 Access the Argo CD UI
Step 1: Get the External IP of the UI service
```bash
kubectl get svc argocd-server -n argocd
```

Step 2: Open the UI in your browser
```bash
https://<EXTERNAL-IP>
```
Note: Argo CD uses a self-signed certificate — your browser will warn you.

### 🔐 Log in to Argo CD
Default Credentials:
Username: admin

Password:
```bash
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 -d && echo
```
You will be prompted to change the password after your first login.
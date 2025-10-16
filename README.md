# Terraform AKS + ACR Deployment

This Terraform project provisions:
- Azure Resource Group
- Azure Container Registry (ACR)
- Azure Kubernetes Service (AKS)
- Role assignment for ACR pull access

## Usage
```bash
terraform init
terraform plan
terraform apply -auto-approve

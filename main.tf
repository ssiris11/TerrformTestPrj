terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "tfstateaks123"
    container_name       = "tfstate"
    key                  = "aks-demo.tfstate"
  }
}



# 1️⃣ Resource Group
module "rg" {
  source   = "./modules/resource_group"
  name     = "${var.prefix}-rg"
  location = var.location
  tags     = var.tags
}

# 2️⃣ Virtual Network & Subnet
module "network" {
  source   = "./modules/network"
  rg_name  = module.rg.name
  location = var.location
  prefix   = var.prefix
  tags     = var.tags
}

# 3️⃣ Azure Container Registry
module "acr" {
  source   = "./modules/acr"
  rg_name  = module.rg.name
  location = var.location
  prefix   = var.prefix
  tags     = var.tags
}

# 4️⃣ AKS Cluster
module "aks" {
  source          = "./modules/aks"
  rg_name         = module.rg.name
  location        = var.location
  prefix          = var.prefix
  subnet_id       = module.network.subnet_id
  acr_id          = module.acr.id
  tags            = var.tags
}

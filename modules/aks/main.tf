resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.prefix}-dns"

  default_node_pool {
    name           = "nodepool1"
    node_count     = 2
    vm_size        = "Standard_B2s"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "10.240.0.0/16" # Non-overlapping CIDR
    dns_service_ip = "10.240.0.10"   # Inside service_cidr
    # docker_bridge_cidr = "172.17.0.1/16"     # Must not overlap with subnet/VNet
  }
  # Attach ACR to AKS (for image pulls)
  depends_on = [var.acr_id]

  tags = var.tags
}

# Give AKS pull permissions on ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}

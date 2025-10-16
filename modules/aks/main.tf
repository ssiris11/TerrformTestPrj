resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "${var.prefix}-dns"

  default_node_pool {
    name       = "nodepool1"
    node_count = 2
    vm_size    = "Standard_B2s"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
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

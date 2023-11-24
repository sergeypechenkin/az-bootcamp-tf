# Deploy AKS cluster into an existing virtual network
resource "azurerm_resource_group" "rg" {
  name = "rg-aks"
  location = var.resource_group_location
}

resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

resource "azurerm_virtual_network" "aks-vnet" {
  name = "vnet-aks"
  location = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  address_space = ["10.10.0.0/16"]  
}

resource "azurerm_subnet" "aks-subnet" {
  name = "aks-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes = ["10.10.1.0/24"]
}

resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = random_pet.azurerm_kubernetes_cluster_name.id  
  resource_group_name = azurerm_resource_group.rg.name
  kubernetes_version  = var.k8s_version
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count 
    vnet_subnet_id = azurerm_subnet.aks-subnet.id
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin  = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "Development"    
  }
}
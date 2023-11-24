resource "azurerm_virtual_network_peering" "aks-hub-peer" {
    name = "aks-hub-peer"
    resource_group_name = azurerm_virtual_network.aks-vnet.resource_group_name
    virtual_network_name = azurerm_virtual_network.aks-vnet.name
    remote_virtual_network_id = var.hub-vnet-id        
    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit = false
    use_remote_gateways = true
    depends_on = [azurerm_virtual_network.aks-vnet]  
}

resource "azurerm_virtual_network_peering" "hub-aks-peer" {
    name = "hub-aks-peer"
    resource_group_name = "rg-hub-vnet"
    virtual_network_name = "vnet-hub"
    remote_virtual_network_id = azurerm_virtual_network.aks-vnet.id    
    allow_virtual_network_access = true
    allow_forwarded_traffic = true
    allow_gateway_transit = true
    use_remote_gateways = false
    depends_on = [azurerm_virtual_network.aks-vnet]  
}
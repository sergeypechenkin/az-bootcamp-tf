locals {}


resource "azurerm_resource_group" "rg-vnet-hub" {
    name     = var.rg-vnet-hub
    location = var.location
}

resource "azurerm_virtual_network" "hub-vnet" {
    name                = "vnet-${var.vnet-hub-name}"
    location            = azurerm_resource_group.rg-vnet-hub.location
    resource_group_name = azurerm_resource_group.rg-vnet-hub.name
    address_space       = ["10.0.0.0/16"]

    tags = {
    environment = "hub-spoke"
    }
}

resource "azurerm_subnet" "hub-gateway-subnet" {
    name                 = "GatewaySubnet"
    resource_group_name  = azurerm_resource_group.rg-vnet-hub.name
    virtual_network_name = azurerm_virtual_network.hub-vnet.name
    address_prefixes     = ["10.0.255.224/27"]
}

resource "azurerm_subnet" "hub-mgmt" {
    name                 = "mgmt"
    resource_group_name  = azurerm_resource_group.rg-vnet-hub.name
    virtual_network_name = azurerm_virtual_network.hub-vnet.name
    address_prefixes       = ["10.0.0.64/27"]
}

resource "azurerm_subnet" "hub-dmz" {
    name                 = "dmz"
    resource_group_name  = azurerm_resource_group.rg-vnet-hub.name
    virtual_network_name = azurerm_virtual_network.hub-vnet.name
    address_prefixes       = ["10.0.0.32/27"]
}

# Virtual Network Gateway
resource "azurerm_public_ip" "hub-vpn-gateway1-pip" {
    name                = "hub-vpn-gw-pip"
    location            = azurerm_resource_group.rg-vnet-hub.location
    resource_group_name = azurerm_resource_group.rg-vnet-hub.name

    allocation_method = "Dynamic"
}

# Refer to existing rsg and key vault
data "azurerm_resource_group" "rgKV" {
  name = var.rgKV
}

# Refer to existing key vault
data azurerm_key_vault "kvP2S" {
  name                = var.kv
  resource_group_name = data.azurerm_resource_group.rgKV.name
}

# Refer to existing secret
data "azurerm_key_vault_secret" "kvP2S" {  
  name         = var.kvsecret
  key_vault_id = data.azurerm_key_vault.kvP2S.id
}


resource "azurerm_virtual_network_gateway" "hub-vnet-gateway" {
    name                = "hub-vpn-gw"
    location            = azurerm_resource_group.rg-vnet-hub.location
    resource_group_name = azurerm_resource_group.rg-vnet-hub.name

    type     = "Vpn"
    vpn_type = "RouteBased"

    active_active = false
    enable_bgp    = false
    sku           = "VpnGw1"

    ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.hub-vpn-gateway1-pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.hub-gateway-subnet.id
    }

    vpn_client_configuration {
      address_space = ["172.16.20.0/24"]

      root_certificate {
        name = "P2S"
        public_cert_data = data.azurerm_key_vault_secret.kvP2S.value
      }
    }
    depends_on = [azurerm_public_ip.hub-vpn-gateway1-pip]
}


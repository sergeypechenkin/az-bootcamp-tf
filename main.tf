

module "hub-and-spoke" {
  source = "./modules/hub-and-spoke"
  location = "East US"
  rg-vnet-hub = "rg-hub-vnet"
  rg-spoke-01-vnet = "rg-spoke01-vnet"
  rg-spoke-02-vnet = "rg-spoke02-vnet"
  vnet-hub-name = "hub"
  vnet-spoke-01-name = "spoke01"
  vnet-spoke-02-name = "spoke02"
  # Existing key vault 
  rgKV = "rgKV"
  kv= "kvP2S"
  kvsecret = "P2S"
}

module "aks" {
  source = "./modules/aks"
  resource_group_location = "East US"  
  node_count = 3
  hub-vnet-id = module.hub-and-spoke.hub-vnet-id
  
} 

module "vm" {
  source = "./modules/vm/windows-aad"
  name = "vm01"  
  resource_group_name = "rg-VM"
  subnet_id = module.hub-and-spoke.subnet-spoke01-workload-id
  location = "East US"  
  admin_username = "azureadmin"
  tags = {Environment=Development}
  depends_on = [ module.aks, module.hub-and-spoke ]
}

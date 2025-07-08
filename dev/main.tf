data "azurerm_subnet" "frontend" {
  depends_on = [ module.subnet ]
  name                 = "frontend"
  virtual_network_name = "dev-vnet"
  resource_group_name  = "dev-resource-group"
}

module "rg"{
  source = "../module/resource_group"
  rg_name = "dev-resource-group"
  location = "East US"
}

module "vnet" {
  source = "../module/vnet"
  depends_on = [ module.rg ]
 vnet_name = "dev-vnet"
  resource_group_name ="dev-resource-group"
  location            = "East US"
  address_space       = ["10.0.0.0/16"]

}

module "subnet" {
  source = "../module/subnet"
  depends_on = [ module.vnet ]

  frontend11_name                = "dev-subnet"
  resource_group_name  = "dev-resource-group"
  virtual_network_name = "dev-vnet"
  address_prefixes     = ["10.0.0.0/24"]
}

module "public_ip" {
  source = "../module/public_ip"
  depends_on = [ module.rg ]

         public_ip_name   = "dev-public-ip"
  resource_group_name = "dev-resource-group"
  location            = "East US"

}
module "vm" {
    source = "../module/vm"
    depends_on = [ module.subnet, module.public_ip ]

    nic_name                = "dev-nic"
    vm_name                = "dev-vm"
    resource_group_name = "dev-resource-group"
    location            = "East US"
    subnet_id           = data.azurerm_subnet.frontend.id


}

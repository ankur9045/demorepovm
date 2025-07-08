
resource"azurerm_subnet" "frontend1"{
    name = var.frontend11_name
    resource_group_name = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes = var.address_prefixes
}
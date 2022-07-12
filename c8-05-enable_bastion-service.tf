/*resource "azurerm_subnet" "bastion_service_subnet" {
  name = var.bastion_service_subnet_name
  #name of the subnet=vnetname-variable define in subnet
  resource_group_name  = azurerm_resource_group.rg.name    #coming from tfstate file
  virtual_network_name = azurerm_virtual_network.vnet.name #tfstate name
  address_prefixes     = var.bastion_service_address_prefixes
}
resource "azurerm_public_ip" "bastion_service_publicip" {
  name                = "${local.resource_name_prefix}-bastion-service-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  # domain_name_label = "app1-vm-${random_string.myrandom.id}"
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = "${local.resource_name_prefix}-bastion-service"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name = "configuration"
    subnet_id = azurerm_subnet.bastion_service_subnet.id 
    public_ip_address_id = azurerm_public_ip.bastion_service_publicip.id
  }
}*/
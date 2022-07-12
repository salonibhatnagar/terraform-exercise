/*resource "azurerm_subnet" "bastionsubnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.bastion_subnet_name}"
  #name of the subnet=vnetname-variable define in subnet
  resource_group_name  = azurerm_resource_group.rg.name    #coming from tfstate file
  virtual_network_name = azurerm_virtual_network.vnet.name #tfstate name
  address_prefixes     = var.bastion_subnet_address
}
resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name                = "${azurerm_subnet.bastionsubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

####asociate nsg and subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_associate" {
  subnet_id                 = azurerm_subnet.bastionsubnet.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
}
#locaL BLOCK FOR NSG
locals {
  bastion_inbound_ports_maps = {
    "100" : "3389",
    "110" : "2222"

  }
}
# nsg inbound rule
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
  for_each                    = local.bastion_inbound_ports_maps
  name                        = "Rule-Port-${each.value}" #Rule-port-80
  priority                    = each.key                  #100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value #80
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}
*/
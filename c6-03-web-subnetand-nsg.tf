resource "azurerm_subnet" "websubnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  #name of the subnet=vnetname-variable define in subnet
  resource_group_name  = azurerm_resource_group.rg.name    #coming from tfstate file
  virtual_network_name = azurerm_virtual_network.vnet.name #tfstate name
  address_prefixes     = var.web_subnet_adress
}
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${azurerm_subnet.websubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

####asociate nsg and subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
  subnet_id                 = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
#locaL BLOCK FOR NSG
locals {
  web_inbound_ports_maps = {
    "100" : "80",
    "110" : "443",
    "120" : "2222"
  }
}
# nsg inbound rule
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each                    = local.web_inbound_ports_maps
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
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}

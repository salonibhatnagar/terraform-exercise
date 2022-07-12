##public ip
resource "azurerm_public_ip" "web_lbpublicip" {
  name = "${local.resource_name_prefix}-lbpublicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = local.common_tags
}
#this will create your load balancer
resource "azurerm_lb" "web_lb" {
  name = "${local.resource_name_prefix}-lbpublicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  frontend_ip_configuration {
      name = "web-lb-publicip-1"
      public_ip_address_id = azurerm_public_ip.web_lbpublicip.id
  }
}

#create lb backend pool
resource "azurerm_lb_backend_address_pool" "web_lb_backend_address_pool" {
  name = "web-backend"
  loadbalancer_id = azurerm_lb.web_lb.id
}

#health check load balancer
resource "azurerm_lb_probe" "web_lb_probe" {
  name = "tcp-probe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.web_lb.id
  #resource_group_name = azurerm_resource_group.rg.name 
}

resource "azurerm_lb_rule" "web_lb_rule_app1" {
  name = "web-app1-rule"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  #backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id 
  probe_id = azurerm_lb_probe.web_lb_probe.id 
  loadbalancer_id = azurerm_lb.web_lb.id
  #resource_group_name = azurerm_resource_group.name
}

#we will assocaite network interface and standard load balancer
resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lib_assocaite" {
  for_each = var.web_linuxvm_instance_count
  network_interface_id = azurerm_network_interface.web_linuxvm_nic[each.key].id
  ip_configuration_name = azurerm_network_interface.web_linuxvm_nic[each.key].ip_configuration[0].name 
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id 
}
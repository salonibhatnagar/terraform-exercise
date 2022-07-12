/*#bastion host public ip
resource "azurerm_public_ip" "bastion_linuxvm_publicip" {
  name                = "${local.resource_name_prefix}-bastion-linuxvm-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  #domain_name_label = "app1-vm-${random_string.myrandom.id}"
}

#bastion host nic card
resource "azurerm_network_interface" "bastion_linuxvm_nic" {

  name                = "${local.resource_name_prefix}-bastion-linuxvm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "web-linuxvm-ip-1"
    subnet_id                     = azurerm_subnet.bastionsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_linuxvm_publicip.id
  }
}
#we want launch bastion vm

resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {

  name                = "${local.resource_name_prefix}-bastion-linuxvm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  #computer_name = "devlinux-vm1-${count.index}"
  size           = "Standard_B1s"
  admin_username = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.bastion_linuxvm_nic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  #custom_data = filebase64("${path.module}/app-script/redhat-webvm-script.sh")
}*/
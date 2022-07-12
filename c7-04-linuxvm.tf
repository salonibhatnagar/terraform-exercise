resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  for_each = var.web_linuxvm_instance_count
  name                = "${local.resource_name_prefix}-web-linuxvm-${each.key}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  #computer_name = "devlinux-vm1-${count.index}"
  size           = "Standard_B1s"
  admin_username = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_linuxvm_nic[each.key].id
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
  custom_data = filebase64("${path.module}/app-script/redhat-webvm-script.sh")
}
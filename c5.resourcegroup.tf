resource "azurerm_resource_group" "rg" {
  name = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  #name = var.resource_group_name
  #sap-dev-rg-default-random once created where will it be stored it is going to create an unique rg and store it in tfstatefile
  location = var.resource_group_location
  tags     = local.common_tags
}
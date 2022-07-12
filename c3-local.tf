#define the local value in terraform
locals {
  owners               = var.business_division
  environment          = var.environment
  resource_name_prefix = "${var.business_division}-${var.environment}"
  #sap                         #dev
  ####sap-dev
  common_tags = {
    creator = local.owners
    #key = value how do i get the value(in value we have define local.owner=which container var.devision it is coming from generic input variabel file)
    environment = local.environment
  }
}
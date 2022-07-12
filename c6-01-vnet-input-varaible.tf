#here we are going to define varaible for vnet nsg and subnet
variable "vnet_name" {
  type    = string
  default = "vnet-default"
}
variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
#web subnet name and address
variable "web_subnet_name" {
  type    = string
  default = "websubnet"
}
variable "web_subnet_adress" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
#bastion subnet name and address
variable "bastion_subnet_name" {
  type    = string
  default = "bastionsubnet"
}
variable "bastion_subnet_address" {
  type    = list(string)
  default = ["10.0.100.0/24"]
}
#app subnet name and address
variable "app_subnet_name" {
  type    = string
  default = "appsubnet"
}
variable "app_subnet_adress" {
  type    = list(string)
  default = ["10.0.11.0/24"]
}
#dbsubnet name and address
variable "db_subnet_name" {
  type    = string
  default = "dbsubnet"
}
variable "db_subnet_adress" {
  type    = list(string)
  default = ["10.0.21.0/24"]
}
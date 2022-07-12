#all the generic input varaibles
variable "business_division" {
  description = "business division in the large organization" #this is optional
  type        = string                                        #string numeric map (when you want to define two variable together)
  default     = "sap"
}
variable "environment" {
  type    = string
  default = "dev"
}

variable "resource_group_name" {
  type    = string
  default = "rg-default"
}

variable "resource_group_location" {
  type    = string
  default = "eastus"
}
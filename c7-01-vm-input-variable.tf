#linux vm input varaible
variable "web_linuxvm_instance_count" {
  description = "web linux vm instance count"
  type = map(string)
  default = {
    "vm1" = "1022",
    "vm2" = "2022"
  }
}
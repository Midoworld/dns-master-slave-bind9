variable "mysql_prefix" {}
variable "mysql_suffix" {}

variable "mysql_server" {
  type = "list"
}

variable "mysql_administrator_login" {}
variable "mysql_administrator_password" {}

variable "mysql_config" {
  type = "list"
}

variable "mysql_db_firewall" {
  type = "list"
}

variable "mysql_db" {
  type = "list"
}

variable "mysql_resource_group_name" {}
variable "mysql_location" {}

variable "mysql_subnet_id" {}

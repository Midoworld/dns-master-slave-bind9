#Variables declaration

#Authentication
terraform {
  backend          "azurerm"        {}
  required_version = "0.11.11"
}

variable "subscription_id" {}
variable "tenant_id" {}

variable "service_principals" {
  type = "list"
}

#Common
variable "app_name" {}

variable "env_name" {}
variable "rg_apps_name" {}
variable "rg_infr_name" {}
variable "sa_infr_name" {}

variable "bck_rsv_name" {}

variable "subnets" {
  type = "list"
}

variable "apps_nsgs" {
  type = "list"
}

variable "apps_nsgrules" {
  type = "list"
}

#Load Balancers & Availability Set & Virtual Machines
variable "Lb_sku" {}

variable "Lbs" {
  type = "list"
}

variable "LbRules" {
  type = "list"
}

variable "Availabilitysets" {
  type = "list"
}

variable "Linux_Vms" {
  type = "list"
}

variable "Windows_Vms" {
  type = "list"
}

variable "Linux_Ss_Vms" {
  type = "list"
}

variable "Windows_Ss_Vms" {
  type = "list"
}

variable "app_admin" {}
variable "pass" {}
variable "ssh_key" {}

#Postgre SQL
variable "pgsql_db" {
  type = "list"
}

variable "pgsql_db_firewall" {
  type = "list"
}

variable "pgsql_server" {
  type = "list"
}

variable "pgsql_config" {
  type = "list"
}

variable "pgsql_administrator_login" {}

variable "pgsql_administrator_password" {}

#MySQL 
variable "mysql_db" {
  type = "list"
}

variable "mysql_db_firewall" {
  type = "list"
}

variable "mysql_server" {
  type = "list"
}

variable "mysql_config" {
  type = "list"
}
variable "mysql_vnet_rule" {
  type = "list"
}


variable "mysql_administrator_login" {}

variable "mysql_administrator_password" {}



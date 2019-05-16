resource "azurerm_mysql_server" "mysql_server" {
  count               = "${length(var.mysql_server)}"
  #name                = "${var.mysql_prefix}${lookup(var.mysql_server[count.index], "suffix_name")}${var.mysql_suffix}"
  name                = "${lookup(var.mysql_db[count.index], "suffix_name")}"
  resource_group_name = "${var.mysql_resource_group_name}"
  location            = "${var.mysql_location}"

  sku {
    name     = "${lookup(var.mysql_server[count.index], "sku_name")}"
    capacity = "${lookup(var.mysql_server[count.index], "sku_capacity")}"
    tier     = "${lookup(var.mysql_server[count.index], "sku_tier")}"
    family   = "${lookup(var.mysql_server[count.index], "sku_family")}"
  }

  ssl_enforcement = "${lookup(var.mysql_server[count.index], "ssl_enforcement")}"

  storage_profile {
    storage_mb            = "${lookup(var.mysql_server[count.index], "storage_mb")}"
    backup_retention_days = "${lookup(var.mysql_server[count.index], "backup_retention_days")}"
    geo_redundant_backup  = "${lookup(var.mysql_server[count.index], "geo_redundant_backup")}"
  }

  administrator_login          = "${var.mysql_administrator_login}"
  administrator_login_password = "${var.mysql_administrator_password}"
  version                      = "${lookup(var.mysql_server[count.index], "version")}"
}

resource "azurerm_mysql_database" "mysql_database" {
  count               = "${ "${length(var.mysql_server)}" == "0" ? "0" : "${length(var.mysql_db)}" }"
  #name                = "${lookup(var.mysql_db[count.index], "suffix_name")}db${lookup(var.mysql_db[count.index], "id")}"
  name                = "${lookup(var.mysql_db[count.index], "suffix_name")}"
  resource_group_name = "${element(azurerm_mysql_server.mysql_server.*.resource_group_name,lookup(var.mysql_db[count.index], "id_server"))}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name,lookup(var.mysql_db[count.index], "id_server"))}"
  charset             = "${lookup(var.mysql_db[count.index], "charset")}"
  collation           = "${lookup(var.mysql_db[count.index], "collation")}"
}

resource "azurerm_mysql_firewall_rule" "mysql_firewall_rule" {
  count               = "${ "${length(var.mysql_server)}" == "0" ? "0" : "${length(var.mysql_db_firewall)}" }"
  resource_group_name = "${element(azurerm_mysql_server.mysql_server.*.resource_group_name,lookup(var.mysql_db_firewall[count.index], "id_server"))}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name,lookup(var.mysql_db_firewall[count.index], "id_server"))}"
  name                = "fwrule-${lookup(var.mysql_db_firewall[count.index], "id")}"
  start_ip_address    = "${lookup(var.mysql_db_firewall[count.index], "start_ip")}"
  end_ip_address      = "${lookup(var.mysql_db_firewall[count.index], "end_ip")}"
}

resource "azurerm_mysql_configuration" "mysql_config" {
  count               = "${ "${length(var.mysql_server)}" == "0" ? "0" : "${length(var.mysql_config)}" }"
  name                = "${lookup(var.mysql_config[count.index], "MySQLConfigName")}"
  resource_group_name = "${element(azurerm_mysql_server.mysql_server.*.resource_group_name,lookup(var.mysql_config[count.index], "id_server"))}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name,lookup(var.mysql_config[count.index], "id_server"))}"
  value               = "${lookup(var.mysql_config[count.index], "MySQLConfigValue")}"
}

resource "azurerm_mysql_virtual_network_rule" "vnet_rules" {
  count               = "${length(var.mysql_server)}"
  name                = "${var.mysql_prefix}${lookup(var.mysql_server[count.index], "suffix_name")}${var.mysql_suffix}-vnetrule"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name,count.index)}"
  resource_group_name = "${element(azurerm_mysql_server.mysql_server.*.resource_group_name,count.index)}"
  subnet_id           = "${var.mysql_subnet_id}"
}

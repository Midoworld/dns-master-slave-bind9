output "mysql_server_id" {
  value = "${azurerm_mysql_server.mysql_server.*.id}"
}

output "mysql_server_name" {
  value = "${azurerm_mysql_server.mysql_server.*.name}"
}

output "mysql_admin_login" {
  value = "${azurerm_mysql_server.mysql_server.*.administrator_login}"
}

output "mysql_config_id" {
  value = "${azurerm_mysql_configuration.mysql_config.*.id}"
}

output "mysql_config_name" {
  value = "${azurerm_mysql_configuration.mysql_config.*.name}"
}

output "mysql_config_value" {
  value = "${azurerm_mysql_configuration.mysql_config.*.value}"
}

output "mysql_db_id" {
  value = "${azurerm_mysql_database.mysql_database.*.id}"
}

output "mysql_db_name" {
  value = "${azurerm_mysql_database.mysql_database.*.name}"
}

output "mysql_db_charset" {
  value = "${azurerm_mysql_database.mysql_database.*.charset}"
}

output "mysql_db_collation" {
  value = "${azurerm_mysql_database.mysql_database.*.collation}"
}

output "mysql_fw_id" {
  value = "${azurerm_mysql_firewall_rule.mysql_firewall_rule.*.id}"
}

output "mysql_fw_name" {
  value = "${azurerm_mysql_firewall_rule.mysql_firewall_rule.*.name}"
}

output "rt_ids" {
  value = "${data.azurerm_route_table.route_tables.*.id}"
}

output "rt_names" {
  value = "${data.azurerm_route_table.route_tables.*.name}"
}

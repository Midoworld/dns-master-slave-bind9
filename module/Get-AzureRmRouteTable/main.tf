data "azurerm_route_table" "route_tables" {
  count               = "${length(var.route_tables)}"
  name                = "${element(var.route_tables,count.index)}"
  resource_group_name = "${var.rt_resource_group_name}"
}

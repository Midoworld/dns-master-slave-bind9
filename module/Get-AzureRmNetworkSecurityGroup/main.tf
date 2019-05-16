data "azurerm_network_security_group" "nsgs" {
  count               = "${length(var.nsgs)}"
  name                = "${element(var.nsgs,count.index)}"
  resource_group_name = "${var.nsg_resource_group_name}"
}

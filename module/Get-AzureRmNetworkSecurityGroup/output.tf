output "nsg_ids" {
  value = "${data.azurerm_network_security_group.nsgs.*.id}"
}

output "nsg_names" {
  value = "${data.azurerm_network_security_group.nsgs.*.name}"
}

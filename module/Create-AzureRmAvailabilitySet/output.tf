output "ava_set_ids" {
  value = ["${concat(azurerm_availability_set.ava_set.*.id,var.emptylist)}"]
}

output "ava_set_names" {
  value = ["${azurerm_availability_set.ava_set.*.name}"]
}

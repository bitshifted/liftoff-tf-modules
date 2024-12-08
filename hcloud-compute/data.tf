
locals {
  network_names = concat(var.hcloud_server_config.private_networks, flatten(var.hcloud_server_list[*].private_networks))
}

data "hcloud_network" "networks" {
  for_each = toset(local.network_names)
  name     = each.value
}
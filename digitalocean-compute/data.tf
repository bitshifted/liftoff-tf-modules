
data "digitalocean_vpc" "target_vpc_by_name" {
  count = var.docean_server_config.vpc_name != null ? 1 : 0
  name = var.docean_server_config.vpc_name
}


data "digitalocean_vpc" "target_vpc_list" {
  for_each = toset([for srv in var.docean_server_list: srv.vpc_name])
  name = each.value
}

data "digitalocean_projects" "all_projects" {

}
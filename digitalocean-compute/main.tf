
resource "digitalocean_droplet" "droplet" {
  count = var.docean_server_config.num_servers
  name = var.docean_server_config.num_servers > 1 ? "${var.docean_server_config.server_name}-${count.index}" : var.docean_server_config.server_name
  image = var.docean_server_config.os_image
  size = var.docean_server_config.instance_type
  region = var.docean_server_config.region
  user_data = var.docean_server_config.user_data_file_path != null ? file("${var.docean_server_config.user_data_file_path}") : null
  ssh_keys = var.docean_server_config.ssh_key_names
  ipv6 = var.docean_server_config.enable_public_ipv6
  tags = length(var.docean_server_config.tags) > 0 ? var.docean_server_config.tags : var.global_tags
  resize_disk = var.docean_server_config.resize_disk
  backups = var.docean_server_config.enable_backups
  vpc_uuid = var.docean_server_config.vpc_name != null ? data.digitalocean_vpc.target_vpc_by_name[0].id : null
}

locals {
  vpc_name_id_map = {for vpc in data.digitalocean_vpc.target_vpc_list: vpc.name => vpc.id}
   # create map of projects for easier access
  projects_by_name_map = tomap({for proj in data.digitalocean_projects.all_projects.projects: proj.name => proj})
#   # unique project names from vars
  project_names_set = toset([for srv in var.docean_server_list: srv.project_name if srv.project_name != null && srv.project_name != "" && try(contains(keys(local.projects_by_name_map),srv.project_name),false)])
#   # map project names to VPC names
  project_name_to_server_name_map = {for name in local.project_names_set: name => [for srv in var.docean_server_list: srv.server_name if srv.project_name == name]}
}

resource "digitalocean_droplet" "named_server" {
  for_each    = { for srv in var.docean_server_list : srv.server_name => srv }
  name = each.value.server_name
  image = each.value.os_image
  size = each.value.instance_type
  region = each.value.region
  user_data = each.value.user_data_file_path != null ? file("${each.value.user_data_file_path}") : null
  ssh_keys = each.value.ssh_key_names
  ipv6 = each.value.enable_public_ipv6
  tags = length(each.value.tags) > 0 ? each.value.tags : var.global_tags
  resize_disk = each.value.resize_disk
  backups = each.value.enable_backups
  vpc_uuid = each.value.vpc_name != null ? local.vpc_name_id_map[each.value.vpc_name] : null # make this correct
}

# assign named server to projects
resource "digitalocean_project_resources" "named_server_project_resources" {
  for_each = local.project_name_to_server_name_map
  project = local.projects_by_name_map[each.key].id
  resources = [for vpc_name in each.value: digitalocean_droplet.named_server[vpc_name].urn]
}


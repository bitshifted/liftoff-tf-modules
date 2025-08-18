# Terraform Module: hcloud-compute

## Overview

This module manages Hetzner Cloud servers using Terraform. It allows you to create multiple servers with custom images, types, locations, labels, networks, and more, supporting flexible compute configuration for your infrastructure.

## Features

- Create and manage Hetzner Cloud servers
- Supports custom images, instance types, locations, datacenters
- Configure public and private networks
- Attach SSH keys, user data, and labels
- Supports backups and delete protection
- Flexible server naming and scaling

## Usage

```hcl
module "hcloud_compute" {
	source = "github.com/bitshifted/liftoff-tf-modules//hcloud-compute?ref=v2.0.0"

	hcloud_server_list = [
		{
			server_name      = "test-server"
			num_servers      = 2
			os_image         = "ubuntu-24.04"
			instance_type    = "cx22"
			location         = "fsn1"
			datacenter       = "fsn1-dc8"
			user_data_file_path = "cloud-init.yaml"
			ssh_key_names    = ["main-key"]
			enable_public_ipv4 = true
			enable_public_ipv6 = false
			labels           = { environment = "dev" }
			keep_disk        = false
			enable_backups   = false
			enable_delete_protection = false
			private_networks = ["dev-net", "infra-net"]
			dns_zone        = "example.com"
		},
		{
			server_name      = "another-server"
			num_servers      = 1
			os_image         = "ubuntu-24.04"
			instance_type    = "cx22"
			private_networks = ["dev-net"]
		}
	]

	global_labels = {
		project = "myproject"
	}
}
```

## Input Variables

| Name                | Type   | Description                                 | Default     |
|---------------------|--------|---------------------------------------------|-------------|
| `global_labels`     | map(string) | Labels to be applied to all resources. Can be overridden on resource level. | `{}`        |
| `hcloud_server_list`| list(object) | List of server objects with parameters. At least one server configuration must be provided. | n/a         |

## Output Values


| Name          | Description                                 |
|---------------|---------------------------------------------|
| `server_info` | Basic information about created servers. The object contains:
|               | - `public_ip_v4`: Public IPv4 address       |
|               | - `dns_zone`: DNS zone for the server       |
|               | - `provider`: Provider name ("hcloud")      |
|               | - `private_net_info`: List of private network info objects with `net_id`, `ip_address`, and `ip_range` |

## Example

```hcl
module "hcloud_compute" {
	source = "github.com/bitshifted/liftoff-tf-modules//hcloud-compute?ref=v2.0.0"

	hcloud_server_list = [
		{
			server_name      = "test-server"
			num_servers      = 2
			private_networks = ["dev-net", "infra-net"]
		}
	]
}
```

## Requirements

- Terraform >= 1.0
- Provider: hetznercloud/hcloud

## Resources

- `hcloud_server`: Manages Hetzner Cloud servers

## License

This module is licensed under the MPL-2.0. See [LICENSE](../LICENSE) for details.

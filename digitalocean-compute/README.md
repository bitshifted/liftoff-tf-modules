# Terraform Module: digitalocean-compute

## Overview

This module manages DigitalOcean Droplets (servers) using Terraform. It allows you to create multiple servers with custom images, types, regions, tags, VPCs, and more, supporting flexible compute configuration for your infrastructure.

## Features

- Create and manage DigitalOcean Droplets
- Supports custom images, instance types, regions, VPCs
- Configure public and private networks
- Attach SSH keys, user data, and tags
- Supports backups and disk resizing
- Flexible server naming and scaling

## Usage

```hcl
module "digitalocean_compute" {
	source = "../digitalocean-compute"

	docean_server_list = [
		{
			server_name         = "test-server"
			num_servers         = 2
			os_image            = "ubuntu-24-10-x64"
			instance_type       = "s-1vcpu-1gb"
			region              = "fra1"
			user_data_file_path = "cloud-init.yaml"
			ssh_key_names       = ["main-key"]
			enable_public_ipv6  = false
			tags                = ["dev"]
			resize_disk         = true
			enable_backups      = false
			vpc_name            = "dev-vpc"
			project_name        = "myproject"
			dns_zone            = "example.com"
		},
		{
			server_name         = "another-server"
			num_servers         = 1
			os_image            = "ubuntu-24-10-x64"
			instance_type       = "s-1vcpu-1gb"
			vpc_name            = "dev-vpc"
		}
	]

	global_tags = ["project:myproject"]
}
```

## Input Variables

| Name                | Type   | Description                                 | Default     |
|---------------------|--------|---------------------------------------------|-------------|
| `global_tags`       | set(string) | Tags to be applied to all resources. Can be overridden on resource level. | `[]`        |
| `docean_server_list`| list(object) | List of server objects with parameters.     | `[]`        |

## Output Values

| Name          | Description                                 |
|---------------|---------------------------------------------|
| `server_info` | Basic information about created servers. The object contains:
|               | - `public_ip_v4`: Public IPv4 address       |
|               | - `dns_zone`: DNS zone for the server       |
|               | - `provider`: Provider name ("digitalocean")|
|               | - `private_net_info`: List of private network info objects with `net_id`, `ip_address`, and `ip_range` |

## Example

```hcl
module "digitalocean_compute" {
	source = "../digitalocean-compute"

	docean_server_list = [
		{
			server_name         = "test-server"
			num_servers         = 2
			vpc_name            = "dev-vpc"
		}
	]
}
```

## Requirements

- Terraform >= 1.0
- Provider: digitalocean/digitalocean

## Resources

- `digitalocean_droplet`: Manages DigitalOcean Droplets

## License

This module is licensed under the MPL-2.0. See [LICENSE](../LICENSE) for details.

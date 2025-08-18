# Terraform Module: hcloud-net

## Overview

This module manages Hetzner Cloud networks, subnets, and routes using Terraform. It allows you to create multiple networks with custom IP ranges, labels, subnets, and routes, supporting flexible network configuration for your infrastructure.

## Features

- Create and manage Hetzner Cloud networks
- Add subnets to networks with custom types, regions, and IP ranges
- Add routes to networks
- Supports global and per-resource labels

## Usage

```hcl
module "hcloud_net" {
	source = "github.com/bitshifted/liftoff-tf-modules//hcloud-net?ref=v2.0.0"

	hcloud_networks = [
		{
			name      = "dev-net"
			ip_range  = "10.10.0.0/16"
			labels    = { environment = "dev" }
			subnets = [
				{
					type     = "cloud"
					region   = "eu-central"
					ip_range = "10.10.1.0/24"
				}
			]
		},
		{
			name     = "infra-net"
			ip_range = "10.20.0.0/16"
		}
	]

	hcloud_net_routes = [
		{
			network_id  = "dev-net"
			destination = "0.0.0.0/0"
			gateway     = "10.10.1.1"
		}
	]

	hcloud_global_labels = {
		project = "myproject"
	}
}
```

## Input Variables

| Name                 | Type   | Description                                 | Default     |
|----------------------|--------|---------------------------------------------|-------------|
| `hcloud_networks`    | set(object) | Networks to create. Each object has `name`, `ip_range`, optional `delete_protection`, `expose_routes_to_vswitch`, `labels`, and optional `subnets`. | `[]`        |
| `hcloud_net_routes`  | set(object) | Routes to create. Each object has `network_id`, `destination`, and `gateway`. | `[]`        |
| `hcloud_global_labels` | map(string) | Labels to be applied to all resources. Can be overridden on resource level. | `{}`        |

## Output Values

*(No outputs defined in outputs.tf. Add outputs if needed, e.g. network IDs or subnet IDs.)*

## Example

```hcl
module "hcloud_net" {
	source = "github.com/bitshifted/liftoff-tf-modules//hcloud-net?ref=v2.0.0"

	hcloud_networks = [
		{
			name      = "dev-net"
			ip_range  = "10.10.0.0/16"
			labels    = { environment = "dev" }
			subnets = [
				{
					type     = "cloud"
					region   = "eu-central"
					ip_range = "10.10.1.0/24"
				}
			]
		}
	]
}
```

## Requirements

- Terraform >= 1.0
- Provider: hetznercloud/hcloud

## Resources

- `hcloud_network`: Manages Hetzner Cloud networks
- `hcloud_network_subnet`: Manages Hetzner Cloud network subnets
- `hcloud_network_route`: Manages Hetzner Cloud network routes

## License

This module is licensed under the MPL-2.0. See [LICENSE](../LICENSE) for details.

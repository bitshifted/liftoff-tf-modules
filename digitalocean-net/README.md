# Terraform Module: digitalocean-net

## Overview

This module manages DigitalOcean VPC networks using Terraform. It allows you to create multiple VPCs with custom names, regions, IP ranges, and descriptions, supporting flexible network configuration for your infrastructure.

## Features

- Create and manage DigitalOcean VPC networks
- Supports custom name, region, IP range, and description
- Integrate with other DigitalOcean resources

## Usage

```hcl
module "digitalocean_net" {
	source = "github.com/bitshifted/liftoff-tf-modules//digitalocean-net?ref=v2.0.0"

	docean_vpcs = [
		{
			name        = "dev-vpc"
			region      = "nyc3"
			ip_range    = "10.10.0.0/16"
			description = "Development VPC"
		},
		{
			name     = "infra-vpc"
			region   = "fra1"
			ip_range = "10.20.0.0/16"
		}
	]
}
```

## Input Variables

| Name           | Type   | Description                                 | Default     |
|----------------|--------|---------------------------------------------|-------------|
| `docean_vpcs`  | set(object) | VPCs to create. Each object has `name`, `region`, `ip_range`, optional `description`, and optional `project_name`. | n/a         |


## Example

```hcl
module "digitalocean_net" {
	source = "github.com/bitshifted/liftoff-tf-modules//digitalocean-net?ref=v2.0.0"

	docean_vpcs = [
		{
			name        = "dev-vpc"
			region      = "nyc3"
			ip_range    = "10.10.0.0/16"
			description = "Development VPC"
		}
	]
}
```

## Requirements

- Terraform >= 1.0
- Provider: digitalocean/digitalocean

## Resources

- `digitalocean_vpc`: Manages DigitalOcean VPC networks

## License

This module is licensed under the MPL-2.0. See [LICENSE](../LICENSE) for details.

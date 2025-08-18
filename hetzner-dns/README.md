# Terraform Module: hetzner-dns

## Overview

This module manages Hetzner DNS zones and records using Terraform. It allows you to create DNS zones and add DNS records to existing or newly created zones, supporting flexible configuration for multiple domains and records.

## Features

- Create and manage Hetzner DNS zones
- Add multiple DNS records per zone
- Supports custom record types and TTL

## Usage

```hcl
module "hetzner_dns" {
	source = "github.com/bitshifted/liftoff-tf-modules//hetzner-dns?ref=v2.0.0"

	hcloud_dns_zones = [
		{
			name = "example.com"
			ttl  = 3600
		}
	]

	hcloud_dns_records = [
		{
			zone  = "example.com"
			type  = "A"
			name  = "www"
			value = "192.0.2.1"
			ttl   = 3600
		},
		{
			zone  = "example.com"
			type  = "CNAME"
			name  = "api"
			value = "api.example.com"
			ttl   = 3600
		}
	]
}
```

## Input Variables

| Name               | Type   | Description                                 | Default     |
|--------------------|--------|---------------------------------------------|-------------|
| `hcloud_dns_zones` | set(object) | DNS zones to create. Each object has `name` and optional `ttl`. | `[]`        |
| `hcloud_dns_records` | set(object) | DNS records to create. Each object has `zone`, `type`, `name`, `value`, and optional `ttl`. | `[]`        |

## Output Values

*(No outputs defined in outputs.tf. Add outputs if needed, e.g. zone IDs or record IDs.)*

## Example

```hcl
module "hetzner_dns" {
	source = "github.com/bitshifted/liftoff-tf-modules//hetzner-dns?ref=v2.0.0"

	hcloud_dns_zones = [
		{
			name = "example.com"
			ttl  = 3600
		}
	]

	hcloud_dns_records = [
		{
			zone  = "example.com"
			type  = "A"
			name  = "www"
			value = "192.0.2.1"
			ttl   = 3600
		}
	]
}
```

## Requirements

- Terraform >= 1.0
- Provider: hetznercloud/hetznerdns

## Resources

- `hetznerdns_zone`: Manages Hetzner DNS zones
- `hetznerdns_record`: Manages Hetzner DNS records

## License

This module is licensed under the MPL-2.0. See [LICENSE](../LICENSE) for details.

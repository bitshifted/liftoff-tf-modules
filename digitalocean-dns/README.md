# Terraform Module: digitalocean-dns

## Overview

This module manages DigitalOcean DNS zones and records using Terraform. It allows you to create DNS zones and add DNS records to existing or newly created zones, supporting flexible configuration for multiple domains and records.

## Features

- Create and manage DigitalOcean DNS zones
- Add multiple DNS records per zone
- Supports custom record types and TTL
- Ensures CNAME records are properly formatted

## Usage

```hcl
module "digitalocean_dns" {
	source = "github.com/bitshifted/liftoff-tf-modules//digitalocean-dns?ref=v2.0.0"

	do_dns_domains = [
		{
			name       = "example.com"
			ip_address = "192.0.2.1"
		}
	]

	do_dns_records = [
		{
			zone  = "example.com"
			type  = "A"
			name  = "www"
			value = "192.0.2.1"
			ttl   = 300
		},
		{
			zone  = "example.com"
			type  = "CNAME"
			name  = "api"
			value = "api.example.com"
			ttl   = 300
		}
	]
}
```

## Input Variables

| Name             | Type   | Description                                 | Default     |
|------------------|--------|---------------------------------------------|-------------|
| `do_dns_domains` | set(object) | DNS zones to create. Each object has `name` and optional `ip_address`. | `[]`        |
| `do_dns_records` | set(object) | DNS records to create. Each object has `zone`, `type`, `name`, `value`, and optional `ttl`. | `[]`        |

## Output Values

*(No outputs defined in outputs.tf. Add outputs if needed, e.g. domain IDs or record IDs.)*

## Example

```hcl
module "digitalocean_dns" {
	source = "github.com/bitshifted/liftoff-tf-modules//digitalocean-dns?ref=v2.0.0"

	do_dns_domains = [
		{
			name       = "example.com"
			ip_address = "192.0.2.1"
		}
	]

	do_dns_records = [
		{
			zone  = "example.com"
			type  = "A"
			name  = "www"
			value = "192.0.2.1"
			ttl   = 300
		}
	]
}
```

## Requirements

- Terraform >= 1.0
- Provider: digitalocean/digitalocean

## Resources

- `digitalocean_domain`: Manages DigitalOcean DNS zones
- `digitalocean_record`: Manages DigitalOcean DNS records

## License

This module is licensed under the MPL-2.0. See [LICENSE](../LICENSE) for details.

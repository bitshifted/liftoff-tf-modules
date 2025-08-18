# Terraform Module: cloudflare-dns

## Overview

This module manages Cloudflare DNS records using Terraform. It allows you to create and manage DNS zones and records in Cloudflare, supporting flexible configuration for multiple zones and records.

## Features

- Create and manage Cloudflare DNS zones
- Add multiple DNS records per zone
- Supports custom record types, TTL, and proxied settings
- Easy integration with other modules

## Usage

```hcl
module "cloudflare_dns" {
	source = "github.com/bitshifted/liftoff-tf-modules//cloudflare-dns?ref=v2.0.0"

	# Example variable
	dns_zone = "example.com"
	dns_records = [
		{
			name    = "www"
			type    = "A"
			value   = "192.0.2.1"
			ttl     = 300
			proxied = true
		},
		{
			name    = "api"
			type    = "CNAME"
			value   = "api.example.com"
			ttl     = 300
			proxied = false
		}
	]
}
```

## Input Variables

| Name         | Type   | Description                                 | Default     |
|--------------|--------|---------------------------------------------|-------------|
| `dns_zone`   | string | The DNS zone to manage                      | n/a         |
| `dns_records`| list   | List of DNS record objects                  | `[]`        |
| ...          | ...    | ...                                         | ...         |

*(List all variables defined in `variables.tf` for this module.)*

## Output Values

| Name         | Description                                 |
|--------------|---------------------------------------------|
| `zone_id`    | The Cloudflare zone ID                      |
| `record_ids` | List of created DNS record IDs              |
| ...          | ...                                         |

*(List all outputs defined in `outputs.tf` for this module.)*

## Example

```hcl
module "cloudflare_dns" {
	source = "../cloudflare-dns"

	dns_zone = "example.com"
	dns_records = [
		{
			name    = "www"
			type    = "A"
			value   = "192.0.2.1"
			ttl     = 300
			proxied = true
		}
	]
}
```

## Requirements

- Terraform >= 1.0
- Provider: cloudflare/cloudflare

## Resources

- `cloudflare_zone`: Manages Cloudflare DNS zones
- `cloudflare_record`: Manages Cloudflare DNS records

## License

This module is licensed under the MPL-2.0. See [LICENSE](../LICENSE) for details.

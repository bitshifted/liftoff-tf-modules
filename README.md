#  Liftoff Terraform modules

Collection of modules intended primary to be used by [Liftoff](https://github.com/bitshifted/liftoff) project, but can also be used independently. These are modules for alternative cloud providers such as Hetzner, Digital Ocean, Cloudflare etc. 

These modules provide common functionality that is frequently deployed in these clouds, reducing the time and effort needed for configuration.

List of modules:

* [Cloudflare DNS](./cloudflare-dns/README.md) - DNS configuration for Cloudflare
* [Digital Ocean DNS](./digitalocean-dns/README.md) - DNS configuration for Digital Ocean
* [Hetzner DNS](./hetzner-dns/README.md) - DNS configuration for Hetzner (HCloud)
* [Digital Ocean networking](./digitalocean-net/README.md) - network configuration for Digital Ocean
* [Hetzner networking](./hcloud-net/README.md) - networking configuration for Hetzner Cloud (HCloud)
* [Hetzner compute](./hcloud-compute/README.md) - configuration for deploying server instances on Hetzner
* [Digital Ocean compute](./digitalocean-compute/README.md) - configuration for deploying DO droplets


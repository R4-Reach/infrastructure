# infrastructure
handles server configurations "infrastructure-as-code"


## Terraform

Creates servers, see `Makefile` in the terraform folder

## Ansible

Configures servers, see `Makefile` in the ansible folder


## Ops

Stopping services:
- `sudo systemctl stop webapp`, rather than `docker compose down`

Status:
- `sudo systemctl status webapp`
A

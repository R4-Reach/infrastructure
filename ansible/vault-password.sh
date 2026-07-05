#!/bin/bash
# Ansible vault password script.
# Ansible will execute this file and use stdout as the vault password.
set -eu

if [[ -z "${R4_ANSIBLE_VAULT_KEY:-}" ]]; then
  echo "ERROR: R4_ANSIBLE_VAULT_KEY environment variable is not set" >&2
  exit 1
fi

echo "${R4_ANSIBLE_VAULT_KEY}"

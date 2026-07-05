.DEFAULT_GOAL := help
MAKEFLAGS += --always-make --warn-undefined-variables --environment-overrides
SHELL=/bin/bash -eu

SSH_USER ?= $${USER}

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

deps:
	test -n "$${R4_ANSIBLE_VAULT_KEY}"
	test -n "$${R4_LINODE_TOKEN}"

setup: deps ## Prints commands to install ansible (linux)
	uv tool install --force ansible-core --with ansible --with linode_api4
	command -v ansible-lint >/dev/null 2>&1 || uv tool install ansible-lint
	ansible-galaxy collection install -r requirements.yml

check: setup ## Syntax-check and lint the playbook
	@printf '\n\033[1;34m━━ Run Syntax Check ━━\033[0m\n'
	ansible-playbook --syntax-check playbook.yml
	@printf '\n\033[1;34m━━ Run Linters ━━\033[0m\n'
	ansible-lint

show-hosts: setup ## Displays a list of inventory hosts
	ansible-inventory --inventory inventory/linode.yml --graph

verbosity=
#verbosity=-vvv
runAnsible=ANSIBLE_CONFIG="./ansible.cfg" \
	ansible-playbook $(verbosity) \
	  --vault-password-file ./vault-password.sh \
	  -e ansible_user=$(SSH_USER)

plan diff: setup ## Runs ansible diff to show what would change without applying
	$(runAnsible) --check --diff --inventory inventory/linode.yml playbook.yml

apply deploy: setup ## Runs ansible playbook, configures and updates servers
	$(runAnsible) --inventory inventory/linode.yml playbook.yml

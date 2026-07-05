.DEFAULT_GOAL := help
MAKEFLAGS += --always-make --warn-undefined-variables --environment-overrides
SHELL=/bin/bash -eu

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ## Install pre-commit (via uv) and on-push git hook
	uv tool install pre-commit
	pre-commit install --hook-type pre-push --overwrite

format: ## Run all pre-commit hooks against every file
	cd terraform && make format
	pre-commit run --all-files

check: ## Run all checks: pre-commit hooks, terraform, ansible
	@printf '\n\033[1;44;97m  Run Pre-commit Hooks  \033[0m\n'
	pre-commit run --all-files
	@printf '\n\033[1;44;97m  Run Terraform Checks  \033[0m\n'
	cd terraform && make check
	@printf '\n\033[1;44;97m  Run Ansible Checks  \033[0m\n'
	cd ansible && make check

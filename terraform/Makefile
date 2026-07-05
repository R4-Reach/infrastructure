.DEFAULT_GOAL := help
MAKEFLAGS += --always-make --warn-undefined-variables --environment-overrides
SHELL=/bin/bash -eu

TF_VAR_r4_linode_token ?= $(R4_LINODE_TOKEN)
export TF_VAR_r4_linode_token

ifeq ($(TF_VAR_r4_linode_token),)
  $(error Error: set R4_LINODE_TOKEN before running)
endif

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

TF=terraform -chdir=$(PWD)

check: fmt-check validate

init:
	$(TF) init -upgrade

validate: init
	$(TF) validate

plan diff:
	$(TF) plan -input=false -lock=false

apply:
	$(TF) apply -input=false

apply-now:
	$(TF) apply -auto-approve

destroy:
	$(TF) destroy -auto-approve

fmt format:
	$(TF) fmt -recursive

fmt-check format-check:
	@if [ -n "$(shell $(TF) fmt -recursive -check)" ]; then \
		echo "Run 'make fmt' to fix formatting"; exit 1; \
	fi

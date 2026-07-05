This directory holds the Terraform root that creates infrastructure.

## Tokens

Create token for terraform cloud:
- https://app.terraform.io/app/r4-reach/settings/authentication-tokens?tabIndex=1
- store in github: <https://github.com/organizations/R4-Reach/settings/secrets/actions>
- name: TF_TOKEN_APP_TERRAFORM_IO

Create a token in linode:
- permissions: { linode: 'write', ip: 'read' }
- store in github: <https://github.com/organizations/R4-Reach/settings/secrets/actions>
- name: TF_VAR_R4_LINODE_TOKEN

## State File

State is at:
https://app.terraform.io/app/r4-reach/workspaces/infra/states

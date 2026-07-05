## Running in diff mode:
```
make plan SSH_USER=[your ssh user]
```

## Running select roles/tasks

Run a `make plan`, the command being run is outputted. Copy that and add '--tags [tagname]' to the end,
and remove the '--check' for updates to be applied.


## Linode Token

- create the token in linode (the website):
  - <https://cloud.linode.com/profile/tokens>
  - set expiry to never
  - permissions needed, read only: {Images, IPs, Linodes, Volumes}
- set the token up in github:
  - name: R4_LINODE_TOKEN
  - <https://github.com/organizations/R4-Reach/settings/secrets/actions>
- destroy your copy of the linode token value
  - do not save the token value anywhere
  - the token value is read-once, then encrypted. If we ever need it again, regenerate it.

## Ansible Vault Key

- generate with CLI command: `openssl rand -base64 48`
- store in github:
  - name: R4_ANSIBLE_VAULT_KEY
  - <https://github.com/organizations/R4-Reach/settings/secrets/actions>
- locally assign to an environment variable (do this securely): `R4_ANSIBLE_VAULT_KEY`
- Ansible vault key is used when the infrastructure project runs ansible to deploy configurations.
  The vault key is used to decrypt secrets.

# SSH Keys / Server Access

## Special System (SSH) Users

- **ansible**: this is the infrastructure deployment user. This user should be bootstrapped at linode creation, specifically
their SSH public key should be configured as part of linodes when creating them. This grants the ansible user initial
access to the linode. This is done in the terraform configuration. The ansible user has full server access and is used
to do a full configuration. This user should only be used via the 'infrastructure' repository and not otherwise.

- **deploy**: this is a more limited user that is used to trigger application deployments. They have permission to run
a single deployment script, that deployment script should be constrained to pulling docker images and restarting
service. The application repositories will use the 'deploy' user to trigger deployments.

## SSH key creation

Steps for how SSH keys are created and configured:
1. Create private & public keys via: `ssh-keygen -t ed25519`
2. Add private key to github secrets: <https://github.com/organizations/R4-Reach/settings/secrets/actions>
3. Destroy your copy of the private key, delete it.
4. Add public key to where needed

## SSH Key Wiring

- Automated/CICD: SSH keys are provided in github action files via ssh-agent, which is configured to pull
  SSH private keys via github secrets.
- Manual: you use your own username/account and your own SSH keys. You do not use the ansible or deploy user.

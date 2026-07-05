# Terraform variables for the Linode instance
variable "r4_linode_token" {
  description = "Linode Personal Access Token. Set via environment variable: export TF_VAR_r4_linode_token=<your_pat>"
  type        = string
  sensitive   = true
}

variable "admin_pub_file" {
  description = "Path to admins.json: JSON array of {name, ssh_keys[]} bootstrap accounts cloud-init creates on first boot. Not the full admin roster (that lives in Ansible's admin_user role)."
  type        = string
  default     = "keys/admins.json"
}

variable "servers" {
  description = "Map of servers to provision. Key becomes the Linode label. Tags define the server's role (e.g. 'bot', 'lobby')."
  type = map(object({
    destroy = optional(bool, false)
    type    = optional(string, "g6-nanode-1")
    image   = optional(string, "linode/ubuntu24.04")
    region  = string
    tags    = optional(list(string), [])
  }))
}

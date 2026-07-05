locals {
  # Bootstrap accounts for cloud-init (the 'ansible' user). Full admin roster
  # lives in Ansible's admin_user role.
  admins = tolist([
    for admin in jsondecode(file(var.admin_pub_file)) : {
      name     = tostring(admin.name)
      ssh_keys = tolist([for k in admin.ssh_keys : tostring(k)])
    }
  ])
}

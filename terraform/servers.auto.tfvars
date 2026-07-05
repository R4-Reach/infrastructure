servers = {
  wnc-app01 = {
    region  = "us-southeast"
    type    = "g6-nanode-1"
    image   = "linode/ubuntu24.04"
    tags    = ["server"]
    destroy = false
  }
}

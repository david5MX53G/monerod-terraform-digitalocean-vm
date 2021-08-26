resource "digitalocean_droplet" "ubuntu-nyc3" {
  image = "ubuntu-20-04-x64"
  name = "ubuntu-nyc3"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [var.ssh_key_fingerprint]
  user_data = file(var.user_data_file)
}

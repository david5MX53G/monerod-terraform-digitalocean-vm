variable "ssh_key_fingerprint" {
  type=string
  description="fingerprint of ssh key as shown in the Digital Ocean account web interface"
  sensitive=true
}

variable "daemon_username" {
  description="username which will be required to connect with the daemon"
  sensitive=true
  type=string
}

variable "daemon_password" {
  description="password which will be required to connect with the daemon"
  sensitive=true
  type=string
}

variable "download_url" {
  description="URL from which to download the Monero CLI Wallet for Linux"
  type=string
  default="https://downloads.getmonero.org/cli/linux64"
}

variable "droplet_size" {
  description="The unique slug that indentifies the type of Droplet. You can find a list of available slugs at https://api.digitalocean.com/v2/sizes."
  type=string
}

resource "digitalocean_droplet" "ubuntu-nyc3" {
  image = "ubuntu-20-04-x64"
  name = "ubuntu-nyc3"
  region = "nyc3"
  size = var.droplet_size
  private_networking = true
  ssh_keys = [var.ssh_key_fingerprint]
  user_data = templatefile(
    "${path.module}/cloud-init.tpl", 
    {
      daemon_username = var.daemon_username, 
      daemon_password = var.daemon_password, 
      download_url    = var.download_url,
      wget_output-document = "getmonero.cli.tar.gz"
    }
  )
}

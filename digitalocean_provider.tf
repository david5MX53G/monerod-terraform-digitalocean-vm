terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "ssh_key_fingerprint" {
  type=string
  description="fingerprint of ssh key as shown in the Digital Ocean account web interface"
  sensitive=true
}

variable "user_data_file" {
  type=string
  description="full path to digitalocean droplet user data"
}

variable "do_token" {
  description="digital ocean personal access token"
  sensitive=true
  type=string
}

provider "digitalocean" {
  token = var.do_token
}

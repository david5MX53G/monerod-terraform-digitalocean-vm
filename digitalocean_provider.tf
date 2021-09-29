terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  description="digital ocean personal access token"
  sensitive=true
  type=string
}

provider "digitalocean" {
  token = var.do_token
}

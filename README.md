## Intro
Use these files to deploy a Digital Ocean Droplet and run monerod on it. This is useful for syncing and storing the Monero blockchain on a remote server instead of your local computer.

## Setup
### Digital Ocean
1. Log into [Digital Ocean](https://cloud.digitalocean.com/).
2. Add an SSH Key from Settings > Security.
3. Generate a new API token from the "API" page.
4. Save the token somewhere safe.

### Terraform
1. Install terraform.
2. Init terraform in the root of this repository.
3. Run terraform apply.
4. Enter the SSH Key and API token when prompted.

### Monero
1. Download the Monero Wallet from [https://web.getmonero.org/downloads/](https://web.getmonero.org/downloads/).
2. Unpack the download.
3. Run the wallet with the public IP of the Droplet as the daemon host. 

## References
templatefile Function: https://www.terraform.io/docs/language/functions/templatefile.html
monerod: https://monerodocs.org/interacting/monerod-reference/
digitalocean_droplet: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet

terraform {
    required_providers {
        digitalocean = {
            source  = "digitalocean/digitalocean"
            version = "~> 2.0"
        }
    }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {
    type = string
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
    token = var.do_token
}

data "digitalocean_ssh_key" "default" {
    name = "M1 MacBook Pro Default"
}

data "digitalocean_project" "default" {
    name = "Snow Fox Studio"
}

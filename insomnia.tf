resource "digitalocean_droplet" "default" {
    image = "ubuntu-22-04-x64"
    name = "insomnia"
    region = "nyc3"
    size = "s-1vcpu-1gb"
    ssh_keys = [
        data.digitalocean_ssh_key.default.id
    ]
    
    connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        timeout = "3m"
        agent= true
    }

    provisioner "remote-exec" {
        script = "./insomnia.sh"
    }
}

resource "digitalocean_firewall" "web" {
    name = "insomnia-fw"

    droplet_ids = [digitalocean_droplet.default.id]

    inbound_rule {
        protocol         = "tcp"
        port_range       = "22"
        source_addresses = ["0.0.0.0/0", "::/0"]
    }

    inbound_rule {
        protocol         = "tcp"
        port_range       = "80"
        source_addresses = ["0.0.0.0/0", "::/0"]
    }

    inbound_rule {
        protocol         = "tcp"
        port_range       = "443"
        source_addresses = ["0.0.0.0/0", "::/0"]
    }

    inbound_rule {
        protocol         = "icmp"
        source_addresses = ["0.0.0.0/0", "::/0"]
    }

    outbound_rule {
        protocol         = "tcp"
        port_range       = "22"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    outbound_rule {
        protocol         = "tcp"
        port_range       = "80"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    outbound_rule {
        protocol         = "tcp"
        port_range       = "443"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    outbound_rule {
        protocol              = "tcp"
        port_range            = "53"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    outbound_rule {
        protocol              = "udp"
        port_range            = "53"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    outbound_rule {
        protocol              = "icmp"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }
}

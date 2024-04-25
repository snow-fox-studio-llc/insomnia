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
        private_key = file(var.pvt_key)
        timeout = "2m"
    }
    
    provisioner "remote-exec" {
        script = "./insomnia.sh"
    }
}

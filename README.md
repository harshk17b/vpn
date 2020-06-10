# vpn
Configure nextdns and tailscale on linux (specifically Ubuntu) automatically

Script has to be run as sudo. It takes two arguments TailScale Auth Token and NextDNS config id to setup both on an Ubuntu machine.

To run:
`chmod +x setup.sh && sudo ./setup.sh <tailscale_auth_token> <nextdns_config_id>`

# NextDNS

You need to get the NextDNS id before you can use this code. We need to automate [this](https://github.com/nextdns/nextdns/wiki/Debian-Based-Distribution#manual-install).

# Tailscale

You need to setup a node authorization before you can use this code. This can be setup [here](https://login.tailscale.com/admin/authkeys). We need to automate [this](https://tailscale.com/download/linux).

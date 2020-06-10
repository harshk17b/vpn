#!/bin/bash

if [ $# -eq 2 ]
then
  # Get the Linux distribution code name
  release=$(cat /etc/lsb-release | grep "DISTRIB_CODENAME" | cut -d "=" -f2)

  # TailScale
  # Add tailscale's pacakage signing key and repository
  curl "https://pkgs.tailscale.com/stable/ubuntu/$release.gpg" | sudo apt-key add -
  curl "https://pkgs.tailscale.com/stable/ubuntu/focal.list" | sudo tee /etc/apt/sources.list.d/tailscale.list

  # Install Tailscale
  sudo apt update
  sudo apt install tailscale

  # Authenticate and connect your machine to your Tailscale network
  sudo tailscale up --authkey $1

  # NextDNS
  # Add NextDNS pacakage signing key and repository
  wget -qO - https://nextdns.io/repo.gpg | sudo apt-key add -
  echo "deb https://nextdns.io/repo/deb stable main" | sudo tee /etc/apt/sources.list.d/nextdns.list

  # Install NextDNS
  sudo apt install apt-transport-https # only necessary on Debian
  sudo apt update
  sudo apt install nextdns

  # Configure NextDNS
  sudo nextdns install -config $2 -report-client-info -auto-activate
else
  echo "Script requires two arguments <tailscale token> and <nextdns config id>"
fi

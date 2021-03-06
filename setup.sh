#!/bin/bash

# Check if two arguments are provided to the script
if [ $# -eq 2 ]
then
  # Check if tailscale key starts with tskey-
  if [[ $1 =~ ^"tskey-"* ]]
  then
    # Get the Linux distribution code name
    release=$(cat /etc/lsb-release | grep "DISTRIB_CODENAME" | cut -d "=" -f2)

    # Check if tailscale is not installed
    if ! tailscale status > /dev/null
    then
      # TailScale
      # Add tailscale's pacakage signing key and repository
      curl "https://pkgs.tailscale.com/stable/ubuntu/$release.gpg" | sudo apt-key add -
      curl "https://pkgs.tailscale.com/stable/ubuntu/focal.list" | sudo tee /etc/apt/sources.list.d/tailscale.list

      # Install Tailscale
      sudo apt update
      sudo apt install tailscale
    fi

    # Authenticate and connect your machine to your Tailscale network
    sudo tailscale up --authkey $1
    
    # Check if nextdns is not installed
    if ! nextdns version > /dev/null
    then
      # NextDNS
      # Add NextDNS pacakage signing key and repository
      wget -qO - https://nextdns.io/repo.gpg | sudo apt-key add -
      echo "deb https://nextdns.io/repo/deb stable main" | sudo tee /etc/apt/sources.list.d/nextdns.list

      # Install NextDNS
      sudo apt install apt-transport-https # only necessary on Debian
      sudo apt update
      sudo apt install nextdns
    fi

    # Configure NextDNS
    sudo nextdns install -config $2 -report-client-info -auto-activate
  else
    echo "Token Error. Tailscale token should start with 'tskey-'"
  fi
else
  echo "Script requires two arguments <tailscale token> and <nextdns config id>"
fi

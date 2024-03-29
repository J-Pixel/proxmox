#! /bin/bash

IPADDR=$(hostname -I | cut -f1 -d ' ')
echo "$IPADDR  $HOSTNAME.proxmox.com $HOSTNAME" | sudo tee -a /etc/hosts #Add an /etc/hosts entry for your IP address

#Add the Proxmox VE repository:
echo "deb [arch=amd64] http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list

#Add the Proxmox VE repository key:
wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg

chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg  # optional, if you have a non-default umask

apt update && apt upgrade

apt-get install proxmox-ve postfix open-iscsi ifupdown2

reboot

apt remove linux-image-amd64 'linux-image-4.19*'

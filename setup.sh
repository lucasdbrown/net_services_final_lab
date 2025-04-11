#!/bin/bash

echo "Updating system..."
sudo dnf update -y

# Install EPEL repository if not already installed
if ! rpm -q epel-release &> /dev/null
then
    echo "EPEL repository not found, installing..."
    sudo dnf install -y epel-release
else
    echo "EPEL repository is already installed"
fi

# Install Ansible
if ! command -v ansible &> /dev/null
then
    echo "Ansible not found, installing..."
    sudo dnf install -y ansible
else
    echo "Ansible is already installed"
fi
echo "==== Lab 8 Setup ===="
echo "Select the role for this VM:"
select role in "primary_dns" "secondary_dns" "primary_dhcp" "tftp_server" "client" "Exit"; do
  case $role in
    "primary_dns")
      ansible-playbook site.yml --tags "primary_dns"
      break
      ;;
    "secondary_dns")
      ansible-playbook site.yml --tags "secondary_dns"
      break
      ;;
    "primary_dhcp")
      ansible-playbook site.yml --tags "primary_dhcp"
      break
      ;;
    "tftp_server")
      ansible-playbook site.yml --tags "tftp_server"
      break
      ;;
    "client")
      ansible-playbook site.yml --tags "client"
      break
      ;;
    "Exit")
      exit 0
      ;;
  esac
done
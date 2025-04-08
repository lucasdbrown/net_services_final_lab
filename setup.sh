#!/bin/bash

echo "==== Lab 8 Setup ===="
echo "Select the role for this VM:"
select role in "primary_dns" "secondary_dns" "dhcp_server" "tftp_server" "client" "Exit"; do
  case $role in
    "primary_dns")
      ansible-playbook site.yml --tags "primary_dns"
      break
      ;;
    "secondary_dns")
      ansible-playbook site.yml --tags "secondary_dns"
      break
      ;;
    "dhcp_server")
      ansible-playbook site.yml --tags "dhcp_server"
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
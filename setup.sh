#!/bin/bash

echo "Checking if EPEL repo and Ansible are installed"

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
select role in "client" "primary_dhcp" "primary_dns" "secondary_dns" "tftp_server" "Exit"; do
  case $role in
    "client")
      echo "Running playbook for client..."
      ansible-playbook site.yml --tags "client" || { echo "Failed to execute the playbook for client"; exit 1; }
      echo "Playbook for client executed successfully."
      break
      ;;

    "primary_dhcp")
      echo "Running playbook for primary_dhcp..."
      ansible-playbook site.yml --tags "primary_dhcp" || { echo "Failed to execute the playbook for primary_dhcp"; exit 1; }
      echo "Playbook for primary_dhcp executed successfully."
      break
      ;;

    "primary_dns")
      echo "Running playbook for primary_dns..."
      ansible-playbook site.yml --tags "primary_dns" || { echo "Failed to execute the playbook for primary_dns"; exit 1; }
      echo "Playbook for primary_dns executed successfully."
      break
      ;;

    "secondary_dns")
      echo "Running playbook for secondary_dns..."
      ansible-playbook site.yml --tags "secondary_dns" || { echo "Failed to execute the playbook for secondary_dns"; exit 1; }
      echo "Playbook for secondary_dns executed successfully."
      break
      ;;

    "tftp_server")
      echo "Running playbook for tftp_server..."
      ansible-playbook site.yml --tags "tftp_server" || { echo "Failed to execute the playbook for tftp_server"; exit 1; }
      echo "Playbook for tftp_server executed successfully."
      break
      ;;

    "Exit")
      exit 0
      ;;

    *)
      echo "Invalid selection. Please choose a valid option."
      ;;
  esac
done

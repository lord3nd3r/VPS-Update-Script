#!/bin/bash

# Define functions for each distro
update_centos_rhel() {
  ssh -n -l "$username" -p "$port" "$server" 'yum update -y'
}

update_ubuntu_debian() {
  ssh -n -l "$username" -p "$port" "$server" 'apt-get update -y && apt-get upgrade -y'
}

update_arch() {
  ssh -n -l "$username" -p "$port" "$server" 'pacman -Syu'
}

update_suse() {
  ssh -n -l "$username" -p "$port" "$server" 'zypper update'
}

update_freebsd() {
  ssh -n -l "$username" -p "$port" "$server" 'freebsd-update fetch && freebsd-update install'
}

# Define server list as an array
servers=(
  "Centos server1 22 user1"
  "Ubuntu server2 22 user2"
  "Arch server3 22 user3"
  "SUSE server4 22 user4"
  "FreeBSD server5 22 user5"
)

# Set current date
currentdate=$(date +%m%d%y)

# Print start message
printf ">===== Starting on %s =====<\n" "$currentdate"

# Loop through server list and update each server
for line in "${servers[@]}"; do
  read -r -a fields <<< "$line"
  distro=${fields[-1]}
  server=${fields[-3]}
  port=${fields[-2]}
  username=${fields[-1]}

  # Print server information
  printf ">=====%s@%s:%s====<\n" "$username" "$server" "$port"

  # Update server based on distro
  case "$distro" in
    'Centos'|'RHEL')
      update_centos_rhel
      ;;
    'Ubuntu'|'Debian')
      update_ubuntu_debian
      ;;
    'Arch')
      update_arch
      ;;
    'SUSE')
      update_suse
      ;;
    'FreeBSD')
      update_freebsd
      ;;
    *)
      echo "Did you misspell your distribution? Capitalization matters!"
      ;;
  esac
done

# Print finish message
printf ">======== FINISHED =======<\n"

#!/bin/zsh
# Must be run from root acc
echo "en_US.UTF-8 UTF-8" | tee -a /etc/locale.gen
echo "el_GR.UTF-8 UTF-8" | tee -a /etc/locale.gen
echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf 
locale-gen
ln -sf /usr/share/zoneinfo/Europe/Athens /etc/localtime 
hwclock --systohc --utc 
echo "lenovo-laptop" | tee -a /etc/hostname 
echo "127.0.0.1 localhost" | tee -a /etc/hosts
echo "::1 localhost" | tee -a /etc/hosts
echo "127.0.1.1 lenovo-laptop" | tee -a /etc/hosts  

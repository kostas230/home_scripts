#!/bin/sh
# Must be run from root acc

# Locale setup
#echo "KEYMAP=uk" | tee -a /etc/vconsole.conf
echo "en_US.UTF-8 UTF-8" | tee -a /etc/locale.gen
echo "el_GR.UTF-8 UTF-8" | tee -a /etc/locale.gen
echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf 
echo "LC_COLLATE=C" | tee -a /etc/locale.conf 
locale-gen

# Set up timezone
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime 
hwclock --systohc --utc

# hosts configuration
echo "desktop-pc" | tee -a /etc/hostname 
echo "127.0.0.1 localhost" | tee -a /etc/hosts
echo "::1 localhost" | tee -a /etc/hosts
echo "127.0.1.1 desktop-pc" | tee -a /etc/hosts

# Default editor is Vim
echo "export EDITOR=vim" | tee -a /etc/environment

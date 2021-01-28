#!/usr/bin/env bash
# Bootstrap host

# Find the fastest mirror
sudo pacman-mirrors --country Australia && sudo pacman -Syyu 

# Update th system 
sudo pacman --noconfirm -Syu

# Install Ansible and Git
if ! sudo pacman -Qi ansible
then
  sudo pacman --noconfirm -S ansible
fi

if ! sudo pacman -Qi git
then
  sudo pacman --noconfirm -S git
fi

# Install yay dependencies
sudo pacman --noconfirm -S --needed base-devel

# Install yay
if ! sudo pacman -Qi yay
then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
fi

# Install AUR ansible plugin
ansible-galaxy install kewlfft.aur

# Install NVIDIA drivers (Configure after reboot)
sudo mhwd -a pci nonfree 0300

# Clone install repo
mkdir ${HOME}/git
git clone https://github.com/angryninja48/manjaro-install.git

# Enable ssh
sudo systemctl enable sshd.service

# Reboot
sudo reboot

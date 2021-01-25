#!/usr/bin/env bash
# Bootstrap host

# Find the fastest mirror
sudo pacman-mirrors --fasttrack --country Australia && sudo pacman -Syyu 

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
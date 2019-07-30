#!/bin/bash

echo "Setting working directory to macOS directory..."
cd /macos

if [ -z "$(ls -A /macos)" ]; then
  echo "Don't have necessary files, pulling them now..."
  git clone https://github.com/foxlet/macOS-Simple-KVM /macos
  echo "-nographic \\
-vnc :0 -k en-us \\" >> basic.sh
fi

if [ ! -d "/data" ]; then
  echo "Data directory doesn't exist, creating it now..."
  mkdir /data
fi

if [ ! -f "/data/mac_drive.qcow2" ]; then
  echo "Install drive doesn't exist, creating it now..."
  qemu-img create -f qcow2 /data/mac_drive.qcow2 32G
  echo "-drive id=SystemDisk,if=none,file=/data/mac_drive.qcow2 \\
-device ide-hd,bus=sata.4,drive=SystemDisk \\" >> basic.sh
fi

if [ ! -f "/macos/BaseSystem.img" ]; then
  echo "Don't have BaseSystem.img, pulling it now..."
  ./jumpstart.sh --mojave
fi

if [ -f "basic.sh" ]; then
  echo "Running basic.sh and booting MacOS..."
  ./basic.sh
else
  echo "Can't find basic.sh, something went wrong somewhere"
fi

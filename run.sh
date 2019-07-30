#!/bin/bash

export MEM=$MACOS_MEMORY
export CPUS=$MACOS_CPUS
export SYSTEM_DISK=$MACOS_DRIVE
export HEADLESS=1

echo "Setting working directory to macOS directory..."
cd /macos

if [ -z "$(ls -A /macos)" ]; then
  echo "Don't have necessary files, pulling them now..."
  git clone https://github.com/foxlet/macOS-Simple-KVM /macos
fi

if [ ! -d "/data" ]; then
  echo "Data directory doesn't exist, creating it now..."
  mkdir /data
fi

if [ ! -f $SYSTEM_DISK ]; then
  echo "Install drive doesn't exist, creating it now..."
  echo "Drive Size: $MACOS_DRIVE_SIZE"
  echo "Drive Location: $MACOS_DRIVE"
  qemu-img create -f qcow2 $SYSTEM_DISK $MACOS_DRIVE_SIZE
fi

if [ ! -f "/macos/BaseSystem.img" ]; then
  echo "Don't have BaseSystem.img, pulling it now..."
  echo "Version: $MACOS_VERSION"
  ./jumpstart.sh --$MACOS_VERSION
fi

if [ -f "headless.sh" ]; then
  echo "Attempting to boot macOS..."
  echo "Memory: $MEM"
  echo "CPUs: $CPUS"
  ./headless.sh
else
  echo "Can't find headless.sh, something went wrong somewhere"
fi

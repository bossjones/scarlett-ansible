#!/usr/bin/env bash

if [ ! -f /swapfile ]; then
  swapoff -a
  dd if=/dev/zero of=/swapfile bs=1024 count=1024k
  chown root:root /swapfile
  chmod 0600 /swapfile
  mkswap /swapfile
  swapon /swapfile
fi

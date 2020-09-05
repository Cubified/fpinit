#!/bin/sh

if ! command -v mdev >/dev/null; then
  udevadm control --exit
fi

umount -r -a -t nosysfs,noproc,nodevtmpfs,notmpfs
mount -o remount,ro /

sync

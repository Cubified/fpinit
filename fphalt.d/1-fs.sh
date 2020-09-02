#!/bin/sh

USE_MDEV=1

if [ "$USE_MDEV" = "0" ]; then
  udevadm control --exit
fi

umount -r -a -t nosysfs,noproc,nodevtmpfs,notmpfs
mount -o remount,ro /

sync

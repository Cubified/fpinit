#!/bin/sh

unmount -r -a -t nosysfs,noproc,nodevtmpfs,notmpfs
mount -o remount,ro /

sync

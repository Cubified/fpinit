#!/bin/sh

mkdir -p /dev
mountpoint -q /dev || mount -t devtmpfs dev /dev -o mode=0755,nosuid
mkdir -p /dev/pts
mountpoint -q /dev/pts || mount -n -t devpts devpts /dev/pts -o mode=0620,gid=5,nosuid,noexec,noatime

mkdir -p /proc
mkdir -p /sys
mkdir -p /run

mountpoint -q /proc || mount -t proc  proc /proc -o nosuid,noexec,nodev
mountpoint -q /sys  || mount -t sysfs sys  /sys  -o nosuid,noexec,nodev
mountpoint -q /run  || mount -t tmpfs run  /run  -o mode=0755,nosuid,nodev

mkdir -p -m 1777 /run/lock
mkdir -p /dev/shm
mountpoint -q /dev/shm || mount -n -t tmpfs shm /dev/shm -o mode=1777,nosuid,nodev,noatime

ln -s /proc/self/fd /dev/fd
ln -sf /proc/mounts /etc/mtab

mountpoint -q /sys/fs/cgroup || mount -n -t cgroup nodev /sys/fs/cgroup

mount -o remount,rw /
mount -a

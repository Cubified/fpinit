#!/bin/sh

mdev -s
echo /sbin/mdev > /proc/sys/kernel/hotplug

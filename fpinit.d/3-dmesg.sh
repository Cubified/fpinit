#!/bin/sh

dmesg > /var/log/dmesg
if [ -e /proc/sys/kernel/dmesg_restrict ] && [ $(cat /proc/sys/kernel/dmesg_restrict) = "1" ]; then
  chmod 0600 /var/log/dmesg
else
  chmod 0644 /var/log/dmesg
fi

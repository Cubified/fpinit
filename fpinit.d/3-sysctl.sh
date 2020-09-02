#!/bin/sh

sysctl -p /etc/sysctl.conf &>/dev/null
for p in /etc/sysctl.d; do
  if [ -d $p ]; then
    for f in $(ls -1 $p); do
      sysctl -p $f &>/dev/null
    done
  fi
done

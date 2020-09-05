#!/bin/sh

sysctl -p /etc/sysctl.conf >/dev/null
for p in /etc/sysctl.d/*; do
  if [ -d "$p" ]; then
    for f in "$p"/*; do
      sysctl -p "$f" >/dev/null
    done
  fi
done

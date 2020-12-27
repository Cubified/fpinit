#!/bin/sh

find /sys -name modalias -type f -print 0 | xargs -0 sort -u \
  | xargs modprobe -b -a 2> /dev/null

if [ -e /dev/fb0 ] && ! [ -e /sys/module/fbcon ]; then
  modprobe -b -q fbcon
fi

if [ -f /etc/modules ]; then
  sed -e 's/\#.*//g' -e '/^[[:space:]]*$/d' < /etc/modules \
    | while read -r module args; do
    modprobe -q "$module" "$args"
  done
fi

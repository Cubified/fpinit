#!/bin/sh

if [ -f /etc/modules ]; then
  sed -e 's/\#.*//g' -e '/^[[:space:]]*$/d' < /etc/modules \
    | while read module args; do
    modprobe -q $module $args
  done
fi

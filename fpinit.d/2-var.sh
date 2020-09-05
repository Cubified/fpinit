#!/bin/sh

if [ ! -L /var/lock ] && ! cmp -s /var/lock /run/lock; then
  rm -rf /var/lock 2>/dev/null
  ln -sf /run/lock /var/lock
fi

if [ ! -L /var/run ] && ! cmp -s /var/run /run; then
  rm -rf /var/run 2>/dev/null
  ln -sf /run /var/run
fi

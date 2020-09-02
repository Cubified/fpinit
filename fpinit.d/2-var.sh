#!/bin/sh

if [ ! -L /var/lock ] && [ ! /var/lock -ef /run/lock ]; then
  rm -rf /var/lock 2>/dev/null
  ln -sf /run/lock /var/lock
fi

if [ ! -L /var/run ] && [ ! /var/run -ef /run ]; then
  rm -rf /var/run 2>/dev/null
  ln -sf /run /var/run
fi

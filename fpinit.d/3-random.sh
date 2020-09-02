#!/bin/sh

RANDOM_SEED=/var/lib/misc/random-seed

POOL_SIZE_FILE=/proc/sys/kernel/random/poolsize

[ -c /dev/urandom ] || exit

if [ -f $RANDOM_SEED ]; then
  cat $RANDOM_SEED > /dev/urandom
fi
rm -f $RANDOM_SEED

(
  umask 077
  if [ -e $POOL_SIZE_FILE ]; then
    POOL_SIZE=$(cat $POOL_SIZE_FILE)
    dd if=/dev/urandom of=$RANDOM_SEED count=$(($POOL_SIZE / 4096)) 2>/dev/null
  fi
)

#!/bin/sh

GETTY="getty"

if [ ! -e "/sbin/$GETTY" ]; then
  GETTY="agetty --noclear"
fi

exec setsid /sbin/$GETTY /dev/tty1 38400 linux &
exec setsid /sbin/$GETTY /dev/tty2 38400 linux &
exec setsid /sbin/$GETTY /dev/tty3 38400 linux &

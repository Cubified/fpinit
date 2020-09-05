#!/bin/sh

GETTY="getty"
NOCLEAR=""

if [ ! -e "/sbin/$GETTY" ]; then
  GETTY="agetty"
  NOCLEAR="--noclear"
fi

exec setsid /sbin/$GETTY "$NOCLEAR" /dev/tty1 38400 linux &
exec setsid /sbin/$GETTY /dev/tty2 38400 linux &
exec setsid /sbin/$GETTY /dev/tty3 38400 linux &

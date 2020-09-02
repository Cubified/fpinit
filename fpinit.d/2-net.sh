#!/bin/sh

CFGFILE=/etc/network/interfaces

find_ifaces() {
  awk '$1 == "auto" {for (i = 2; i <= NF; i = i + 1) printf("%s ", $i)}' "$CFGFILE"
}

find_inet() {
  awk -v iface="$1" '$2 == iface {printf("%s", $4)}' "$CFGFILE"
}

for iface in $(find_ifaces); do
  ip link set dev $iface up
  if [ $(find_inet $iface) = "dhcp" ] && [ ! $(pidof udhcpc >/dev/null) ]; then
    udhcpc
  fi
done

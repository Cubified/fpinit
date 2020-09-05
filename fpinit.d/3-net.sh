#!/bin/sh

CFGFILE=/etc/network/interfaces
DHCP="NONE"

find_ifaces() {
  awk '$1 == "auto" {for (i = 2; i <= NF; i = i + 1) printf("%s ", $i)}' "$CFGFILE"
}

find_inet() {
  awk -v iface="$1" '$2 == iface {printf("%s", $4)}' "$CFGFILE"
}

find_addr() {
  awk -v iface="$1" '$2 == iface { hit = 1; next; }; $1 == "address" && hit == 1 { printf("%s/24", $2); hit = 0; }' "$CFGFILE"
}

find_gateway() {
  awk -v iface="$1" '$2 == iface { hit = 1; next; }; $1 == "gateway" && hit == 1 { printf($2); hit = 0; }' "$CFGFILE"
}

if command -v udhcpc >/dev/null; then
  DHCP="udhcpc"
elif command -v dhcpcd >/dev/null; then
  DHCP="dhcpcd"
elif command -v dhclient >/dev/null; then
  DHCP="dhclient"
fi

for iface in $(find_ifaces); do
  ip link set dev "$iface" up
  if [ "$(find_inet "$iface")" = "dhcp" ]; then
    if ! pidof "$DHCP" >/dev/null && [ ! "$DHCP" = "NONE" ]; then
      $DHCP &
    fi
  elif [ "$(find_inet "$iface")" = "static" ]; then
    ip route add "$(find_addr "$iface")" via "$(find_gateway "$iface")" dev "$iface"
  fi
done

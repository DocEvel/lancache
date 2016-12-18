#!/bin/bash

echo "net.ipv6.conf.all.disable_ipv6=1" >/etc/sysctl.d/disable-ipv6.conf
sysctl -p /etc/sysctl.d/disable-ipv6.conf

cat > /etc/resolv.conf <<EOF
domain lan-team.net
search lan-team.net
nameserver 10.10.0.1
EOF

cat > /etc/network/interfaces <<EOF

# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
auto eth0
iface eth0 inet static
    address 10.10.30.90
    netmask 255.255.0.0
    gateway 10.10.0.1

# Ip used for STEAM caching
auto eth0:1
iface eth0:1 inet static
    address 10.10.30.91
    netmask 255.255.0.0

# Ip used for RIOT caching
auto eth0:2
iface eth0:2 inet static
    address 10.10.30.92
    netmask 255.255.0.0

# Ip used for Blizzard caching
auto eth0:3
iface eth0:3 inet static
    address 10.10.30.93
    netmask 255.255.0.0

# Ip used for Hirez caching
auto eth0:4
iface eth0:4 inet static
    address 10.10.30.94
    netmask 255.255.0.0

# Ip used for Origin caching    
auto eth0:5
iface eth0:5 inet static
    address 10.10.30.95
    netmask 255.255.0.0

# Ip used for Sony caching
auto eth0:6
iface eth0:6 inet static
    address 10.10.30.96
    netmask 255.255.0.0

# Ip used for Microsoft caching
auto eth0:7
iface eth0:7 inet static
    address 10.10.30.97
    netmask 255.255.0.0

# Ip used for Tera caching
auto eth0:8
iface eth0:8 inet static
    address 10.10.30.98
    netmask 255.255.0.0

# Ip used for GOG caching
auto eth0:9
iface eth0:9 inet static
    address 10.10.30.99
    netmask 255.255.0.0

# Ip used for ArenaNetworks caching
auto eth0:10
iface eth0:10 inet static
    address 10.10.30.100
    netmask 255.255.0.0

# Ip used for WarGaming caching
auto eth0:11
iface eth0:11 inet static
    address 10.10.30.101
    netmask 255.255.0.0
EOF

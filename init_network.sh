#!/bin/bash

echo "net.ipv6.conf.all.disable_ipv6=1" >/etc/sysctl.d/disable-ipv6.conf
sysctl -p /etc/sysctl.d/disable-ipv6.conf

cat > /etc/resolv.conf <<EOF
domain lan-team.net
search lan-team.net
nameserver 10.10.0.1
EOF

cat > /etc/hostname <<EOF
lancache
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
    network 10.10.0.0
    broadcast 10.10.255.255
    dns-nameservers 10.10.0.1
    dns-search lan-team.net
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

# creating hosts file /etc/hosts
cat > /etc/hosts <<EOF
127.0.0.1       localhost
127.0.1.1       lancache-VM

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

127.1.0.1       lancache-origin-backend
127.1.0.2       lancache-blizzard-backend

#This is the primary IP (of the network card / eth) that your Lancache is using
10.10.30.90     lancache

#The Following are Virtual IP's used by Lancache
10.10.30.91     lancache-steam
10.10.30.92     lancache-riot
10.10.30.93     lancache-blizzard
10.10.30.94     lancache-hirez
10.10.30.95     lancache-origin
10.10.30.96     lancache-sony
10.10.30.97     lancache-microsoft
10.10.30.98     lancache-tera
10.10.30.99     lancache-gog
10.10.30.100    lancache-arenanetworks
10.10.30.101    lancache-wargaming
EOF

# Create the user lancache
sudo adduser --system --no-create-home lancache
sudo addgroup --system lancache
sudo usermod -aG lancache lancache

# Just create the folders:
sudo mkdir -p /srv/lancache/data/blizzard
sudo mkdir -p /srv/lancache/data/microsoft
sudo mkdir -p /srv/lancache/data/installs
sudo mkdir -p /srv/lancache/data/other
sudo mkdir -p /srv/lancache/data/tmp
sudo mkdir -p /srv/lancache/data/hirez/
sudo mkdir -p /srv/lancache/data/origin/
sudo mkdir -p /srv/lancache/data/riot/
sudo mkdir -p /srv/lancache/data/sony/
sudo mkdir -p /srv/lancache/data/steam/
sudo mkdir -p /srv/lancache/logs
sudo mkdir -p /srv/lancache/data/wargaming
sudo mkdir -p /srv/lancache/data/tera
sudo mkdir -p /srv/lancache/data/arenanetworks

# chown 
sudo chown -R lancache:lancache /srv/lancache

# Copy the Lancache file from init.d/ to /etc/init.d/
sudo cp -R init.d/lancache /etc/init.d/lancache
sudo chmod +x /etc/init.d/lancache

# Put it in the standard Boot:
sudo update-rc.d lancache defaults

# Copy limits.conf to /etc/security/limits.conf
sudo cp limits.conf /etc/security/limits.conf

# copy nginx.conf /etc/nginx
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.org
sudo cp conf/nginx.conf /etc/nginx/nginx.conf

# copy nginx settings
sudo mkdir -p /etc/nginx/lancache
sudo cp -R conf/lancache/ /etc/nginx/

# copy vhosts
sudo mkdir -p /etc/nginx/vhosts-enabled
sudo cp -R conf/vhosts-enabled/ /etc/nginx/

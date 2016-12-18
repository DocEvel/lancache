#!/bin/bash

# nginx compilieren mit slice modul
wget http://nginx.org/download/nginx-1.11.7.tar.gz
tar -xf nginx*
cd nginx*

# Configure options taken from the current Ubuntu 12.04 `nginx-light` rules
# with the addition of the slice module, and the removal of a no-longer-valid one
./configure  \
             --prefix=/usr \
             --conf-path=/etc/nginx/nginx.conf \
             --error-log-path=/var/log/nginx/error.log \
             --http-log-path=/var/log/nginx/access.log \
             --lock-path=/var/lock/nginx.lock \
             --pid-path=/var/run/nginx.pid \
             --with-http_gzip_static_module \
             --with-http_ssl_module \
             --with-http_stub_status_module \
             --with-http_slice_module

make -j 8 
make install

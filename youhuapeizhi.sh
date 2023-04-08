#!/bin/bash
worker_processes 4;
worker_rlimit_nofile 100000;
events {
worker_connections 2048;
multi_accept on;
use epoll;
}

http {
server_tokens off;
sendfile on;
tcp_nopush on;
tcp_nodelay on;
access_log off;
error_log error.log crit;
keepalive_timeout 10;
client_header_timeout 10;
client_body_timeout 10;
reset_timedout_connection on;
send_timeout 10;
include mime.types;
default_type text/html;
charset UTF-8;
gzip on;
gzip_disable "msie6";
gzip_proxied any;
gzip_min_length 1000;
gzip_comp_level 6;
gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

open_file_cache max=100000 inactive=20s;
open_file_cache_valid 30s;
open_file_cache_min_uses 2;
open_file_cache_error on;
       server {
          listen 80;
          server_name localhost;
location / { 
        root html;
        index index.html index.htm;
      
}
        error_page  500 502 503   504  /50x.html;
       location = /50x.html {
           root html;
     }
   }
}

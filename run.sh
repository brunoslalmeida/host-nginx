#!/bin/bash
cwd=$(pwd)

docker stop nginx
docker rm nginx

docker run -d \
        -p 80:80 -p 443:443 \
        --hostname nginx \
        --name nginx \
        --restart=always \
        --network internal \
        -v $cwd/opt/ssl:/etc/nginx/ssl:ro \
        -v $cwd/var/log/nginx:/var/log/nginx \
        -v $cwd/etc/conf.d/:/etc/nginx/conf.d:ro \
        -v $cwd/etc/common.d/:/etc/nginx/common.d:ro \
        -v $cwd/etc/default.d/:/etc/nginx/default.d:ro \
        -v $cwd/etc/nginx.conf:/etc/nginx/nginx.conf:ro \
        -v $cwd/usr/share/nginx/html:/usr/share/nginx/html:ro \
        nginx
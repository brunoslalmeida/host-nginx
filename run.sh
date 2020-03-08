#!/bin/bash
docker stop nginx

docker run -d \
        --rm \
        -p 80:80 -p 443:443 \
        --hostname nginx \
        --name nginx \
        --restart=always \
        --network internal \
        -v ./opt/ssl:/etc/nginx/ssl:ro \
        -v ./var/log/nginx:/var/log/nginx \
        -v ./etc/conf.d/:/etc/nginx/conf.d:ro \
        -v ./etc/common.d/:/etc/nginx/common.d:ro \
        -v ./etc/default.d/:/etc/nginx/default.d:ro \
        -v ./etc/nginx.conf:/etc/nginx/nginx.conf:ro \
        -v ./usr/share/nginx/html:/usr/share/nginx/html:ro \
        nginx
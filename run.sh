#!/bin/bash
cwd=$(pwd)

docker stop nginx
docker rm nginx

#Checking if domains file existis
if test -z "$CERTBOT_SSL"; then
  echo "Variável CERTBOT_SSL não encontrada"
  exit -1
fi

docker run -d \
  -p 80:80 \
  -p 443:443 \
  --hostname nginx \
  --name nginx \
  --restart=always \
  --network internal \
  -v $CERTBOT_SSL:/var/lib/letsencrypt:ro \
  -v $cwd/var/log/nginx:/var/log/nginx \
  -v $cwd/etc/conf.d/:/etc/nginx/conf.d:ro \
  -v $cwd/etc/common.d/:/etc/nginx/common.d:ro \
  -v $cwd/etc/default.d/:/etc/nginx/default.d:ro \
  -v $cwd/etc/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v $cwd/usr/share/nginx/html:/usr/share/nginx/html:ro \
  nginx
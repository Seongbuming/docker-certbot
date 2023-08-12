#!/bin/sh

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <domain1> [<domain2> ...]"
    exit 1
fi

DOMAINS=""
for DOMAIN in "$@"; do
    DOMAINS="$DOMAINS -d $DOMAIN"
done

docker build -t certbot .

docker run -it --rm \
    -p 80:80 \
    -v "${PWD}/letsencrypt:/etc/letsencrypt" \
    -v "${PWD}/lib:/var/lib/letsencrypt" \
    certbot certonly --standalone $DOMAINS

docker compose up -d

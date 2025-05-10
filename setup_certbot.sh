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
    -v "${PWD}/letsencrypt:/etc/letsencrypt" \
    -v "${PWD}/lib:/var/lib/letsencrypt" \
    certbot certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials /secrets/cloudflare.ini \
    --dns-cloudflare-propagation-seconds 30 \
    $DOMAINS

docker compose up -d

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && pip3 install --no-cache-dir \
    certbot \
    certbot-dns-cloudflare

COPY cloudflare.ini /secrets/cloudflare.ini
RUN chmod 600 /secrets/cloudflare.ini

WORKDIR /certbot

ENTRYPOINT [ "certbot" ]

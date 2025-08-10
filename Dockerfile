FROM python:3.11-slim

# 기본 패키지 설치
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --no-cache-dir certbot certbot-dns-cloudflare

# 인증 설정 파일 복사 및 권한 설정
COPY cloudflare.ini /secrets/cloudflare.ini
RUN chmod 600 /secrets/cloudflare.ini

WORKDIR /certbot

ENTRYPOINT [ "certbot" ]

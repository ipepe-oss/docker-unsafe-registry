# Extend the official registry image

FROM ubuntu:22.04 as builder
RUN apt-get update && apt-get install -y apache2-utils && \
    mkdir -p /auth && \
    htpasswd -Bbn unsafe R3g1stry > /auth/htpasswd

FROM registry:2
ENV REGISTRY_AUTH=htpasswd REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd
COPY --from=builder /auth/htpasswd /auth/htpasswd
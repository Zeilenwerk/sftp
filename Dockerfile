FROM alpine:latest

ARG ECDSA_HOST_KEY
ENV ECDSA_HOST_KEY=$ECDSA_HOST_KEY
ARG RSA_HOST_KEY
ENV RSA_HOST_KEY=$RSA_HOST_KEY
ARG DSS_HOST_KEY
ENV DSS_HOST_KEY=$DSS_HOST_KEY

RUN apk add --no-cache \
    dropbear \
    openssh-client \
    openssh-sftp-server \
    busybox-suid

RUN addgroup sftp \
    && adduser -D sftp -G sftp \
    && echo 'sftp:temporary-password' | chpasswd \
    && mkdir -p /etc/dropbear \
    && chown -R :sftp /etc/shadow

COPY scripts/*.sh /usr/local/bin/

RUN create-host-keys.sh

USER sftp
EXPOSE 2222

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["dropbear", "-FEwg", "-p", "2222"]

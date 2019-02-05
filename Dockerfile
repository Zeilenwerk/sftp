FROM alpine:latest

RUN apk add --no-cache \
    dropbear \
    openssh-client \
    openssh-sftp-server \
    busybox-suid

RUN addgroup sftp \
    && adduser -D sftp -G sftp \
    && echo 'sftp:temporary-password' | chpasswd \
    && mkdir -p /etc/dropbear \
    && dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key \
    && dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key \
    && dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key \
    && chown -R sftp:sftp /etc/dropbear \
    && chown -R sftp:sftp /etc/shadow

COPY scripts/docker-entrypoint.sh /usr/local/bin/

USER sftp
EXPOSE 2222

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["dropbear", "-FEwg", "-p", "2222"]

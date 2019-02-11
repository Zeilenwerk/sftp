FROM alpine:latest

RUN apk add --no-cache \
    dropbear \
    openssh-client \
    openssh-sftp-server \
    && chgrp -R 0 /etc/passwd \
    && chmod -R g=u /etc/passwd \
    && mkdir -p /etc/dropbear \
    && chgrp -R 0 /etc/dropbear \
    && chmod -R g=u /etc/dropbear

COPY scripts/docker-entrypoint.sh /usr/local/bin/

USER 1001

EXPOSE 2222

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["dropbear", "-FEwg", "-p", "2222"]

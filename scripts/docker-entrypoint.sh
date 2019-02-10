#!/bin/sh

echo -e "temporary-password\n$PASSWORD\n$PASSWORD" | passwd sftp

exec "$@"

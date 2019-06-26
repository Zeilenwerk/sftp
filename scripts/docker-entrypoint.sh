#!/bin/sh

user_name="${USER_NAME:-sftp}"
if [ -z "$USER_ENCRYPTED_PASSWORD" ]; then
  echo "ERROR: Please set USER_ENCRYPTED_PASSWORD"
  exit 1
fi
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${user_name}:${USER_ENCRYPTED_PASSWORD}:$(id -u):0:${user_name} user:/home/${user_name}:/bin/ash" >> /etc/passwd
  fi
fi

host_keys_location='/etc/dropbear'

if [ -n "$ECDSA_HOST_KEY" ]; then
  echo "$ECDSA_HOST_KEY" | base64 -d > "$host_keys_location/dropbear_ecdsa_host_key"
fi
if [ ! -f "$host_keys_location/dropbear_ecdsa_host_key" ]; then
  dropbearkey -t ecdsa -f "$host_keys_location/dropbear_ecdsa_host_key"
fi

if [ -n "$RSA_HOST_KEY" ]; then
  echo "$RSA_HOST_KEY" | base64 -d > "$host_keys_location/dropbear_rsa_host_key"
fi
if [ ! -f "$host_keys_location/dropbear_rsa_host_key" ]; then
  dropbearkey -t rsa -f "$host_keys_location/dropbear_rsa_host_key"
fi

if [ -n "$DSS_HOST_KEY" ]; then
  echo "$DSS_HOST_KEY" | base64 -d > "$host_keys_location/dropbear_dss_host_key"
fi
if [ ! -f "$host_keys_location/dropbear_dss_host_key" ]; then
  dropbearkey -t dss -f "$host_keys_location/dropbear_dss_host_key"
fi

exec "$@"

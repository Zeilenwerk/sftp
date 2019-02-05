#!/bin/sh

host_keys_location='/etc/dropbear'

if [ -n "$ECDSA_HOST_KEY" ]; then
  echo "$ECDSA_HOST_KEY" > "$host_keys_location/dropbear_ecdsa_host_key"
fi
if [ -n "$RSA_HOST_KEY" ]; then
  echo "$RSA_HOST_KEY" > "$host_keys_location/dropbear_rsa_host_key"
fi
if [ -n "$DSS_HOST_KEY" ]; then
  echo "$DSS_HOST_KEY" > "$host_keys_location/dropbear_dss_host_key"
fi

if [ ! -f "$host_keys_location/dropbear_ecdsa_host_key" ]; then
  dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key
fi
if [ ! -f "$host_keys_location/dropbear_rsa_host_key" ]; then
  dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
fi
if [ ! -f "$host_keys_location/dropbear_dss_host_key" ]; then
  dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
fi

chown -R sftp:sftp /etc/dropbear

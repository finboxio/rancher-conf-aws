#! /bin/sh

if [[ "$EBS_VOLUME_NAME" != "" ]]; then
  ebs-volume-setup
fi

exec /usr/local/bin/rancher-gen --config /etc/rancher-conf/config.toml

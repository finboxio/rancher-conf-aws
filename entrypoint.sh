#! /bin/sh

if [[ "$EBS_VOLUME_NAME" != "" ]]; then
  ebs-volume-setup
fi

if [[ "$S3_BUCKET" != "" ]]; then
  s3-pull
fi

if [[ -e /etc/rancher-conf/config.toml ]]; then
  exec rancher-conf --config /etc/rancher-conf/config.toml
fi

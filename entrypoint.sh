#! /bin/sh

if [[ "$EBS_VOLUME_NAME" != "" ]]; then
  ebs-volume-setup
fi

if [[ "$S3_BUCKET" != "" ]]; then
  until s3-pull
  do
    echo "S3 pull failed. Retrying..."
    sleep 1
  done
fi

if [[ -e /etc/rancher-conf/config.toml ]]; then
  exec rancher-conf --config /etc/rancher-conf/config.toml
fi

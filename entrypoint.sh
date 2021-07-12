#!/bin/sh

if [ ! -f "/root/.config/rclone/rclone.conf" ]; then
  echo "Missing rclone ConfigMap mount onto /root/.config/rclone/rclone.conf"
  exit 1
fi

env | grep '^RCLONE_MOUNT_' | while IFS='=' read var mntdef; do
  set -x
  mnt=$(echo ${mntdef} | awk '{print $NF}')
  mkdir -p ${mnt}
  rclone mount --umask=7 --daemon ${mntdef} || exit 1
  set +x
done || exit 1

set -x && /usr/local/bin/entrypoint.sh $@

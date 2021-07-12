#!/bin/sh

if [ ! -f "/root/.config/rclone/rclone.conf" ]; then
  echo "Missing rclone ConfigMap mount onto /root/.config/rclone/rclone.conf"
  exit 1
fi

env | grep '^RCLONE_MOUNT_' | while IFS='=' read var mntdef; do
  echo ${mntdef} | while IFS=' ' read remote mnt; do
    set -x
    mkdir -p ${mnt}
    rclone mount --umask=7 --daemon ${remote} ${mnt} || exit 1
    set +x
  done || exit 1
done || exit 1

set -x && /usr/local/bin/entrypoint.sh $@

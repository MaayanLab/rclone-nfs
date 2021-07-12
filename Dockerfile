FROM erichough/nfs-server

RUN set -x \
  && apk --no-cache add fuse \
  && wget https://downloads.rclone.org/rclone-current-linux-amd64.zip \
  && unzip rclone-current-linux-amd64.zip \
  && cp rclone-*-linux-amd64/rclone /usr/bin \
  && chown root:root /usr/bin/rclone \
  && chmod 755 /usr/bin/rclone \
  && rm -r rclone-*-linux-amd64*

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

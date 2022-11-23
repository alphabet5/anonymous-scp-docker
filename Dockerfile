FROM alpine:latest
LABEL maintainer="alphabet5"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --upgrade \
    sudo \
    openssh && \
  mkdir /files && \
  adduser -D -H -u 1001 -h /files anonymous && \
  sudo passwd -d anonymous && \
  rm -rf \
    /tmp/*

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

EXPOSE 2222/tcp
VOLUME /files

ENTRYPOINT ["/entrypoint.sh"]


FROM ubuntu:20.04

MAINTAINER Nik Parotikov <nik.parotikov@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow

RUN apt-get update
RUN apt-get install -y -qq software-properties-common git cmake g++ libfuse3-dev libcurl4-openssl-dev libjsoncpp-dev dh-make fuse3

ENV MARCFS_REVISION=7df8259cdfd3133f159488a2ee9805c8096b2c18

RUN git clone https://gitlab.com/Kanedias/MARC-FS.git /usr/local/src/marc-fs && \
      cd /usr/local/src/marc-fs && git checkout $MARCFS_REVISION && \
      git submodule init && git submodule update && \
      mkdir /usr/local/src/marc-fs/build && \
      cd /usr/local/src/marc-fs/build && cmake .. && make && \
      mv /usr/local/src/marc-fs/build/marcfs /usr/local/bin/

COPY docker-entrypoint.sh /usr/local/bin/
COPY mount-mail-ru.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

RUN adduser --system app
USER app

RUN mkdir /tmp/mailru
RUN mkdir /tmp/cache

ENV MAILRU_LOGIN=example@mail.ru
ENV MAILRU_PASSWORD=example@mail.ru
ENV MAILRU_AUTOMOUNT=true

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]

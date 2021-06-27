# Cloud Mail.ru in a Docker

[![Docker Build Status](https://img.shields.io/docker/build/parotikov/cloud-mail-ru-docker.svg)](https://hub.docker.com/r/parotikov/cloud-mail-ru-docker/)
[![Docker Pulls](https://img.shields.io/docker/pulls/parotikov/cloud-mail-ru-docker.svg)](https://hub.docker.com/r/parotikov/cloud-mail-ru-docker)


With this image you can mount cloud.mail.ru as a FUSE path. [MARC-FS](https://gitlab.com/Kanedias/MARC-FS.git) is used under the hood. Without GUI login, VNC and so on.

Configure CI to upload builds or write backup scripts with cloud.mail.ru storage.

## Ho To Use

0. Set MAILRU_LOGIN, MAILRU_PASSWORD credentials as env variables
1. Start container with local path mounted as volume in a _privileged_ mode
3. Copy files in both directions

## Configuration

| ENV              | Default | Description                     |
|------------------|---------|---------------------------------|
| MAILRU_LOGIN     |         | login, e.g. 'my.email@mail.ru'  |
| MAILRU_PASSWORD  |         | password                        |
| MAILRU_AUTOMOUNT | true    | Mount clound on container start |


## Example

```bash
$ echo "Hello Mail.ru" > hello.txt
$ docker run -v "$PWD":/local_drive -e MAILRU_LOGIN=my.email@mail.ru -e MAILRU_PASSWORD=secret123 --rm --privileged parotikov/cloud-mail-ru-docker:1.1 cp /local_drive/hello.txt /tmp/mailru/hello.txt
```

## Build
docker build --rm -t parotikov/cloud-mail-ru-docker:1.1 .

## Usage
/bin/bash /root/copy_to_mailru_cloud.sh /home/backup file.tar cloud_dir

## Why?

There some other projects doing pretty the same:

* https://hub.docker.com/r/delfer/cloudmailru/
* https://hub.docker.com/r/dfayruzov/cloudmailru/

So why do we need another one? The key feature of cloud-mail-ru-docker is ability to avoid GUI authentication at all. It is important when using CI to deliver builds, e.g.. 

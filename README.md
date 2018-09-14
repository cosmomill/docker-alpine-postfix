Alpine Postfix Docker image
===========================

This image is based on Alpine Linux image, which is only a 5MB image, and provides a docker image for Postfix.

This image contains only Postfix, no init system or syslog. Postfix runs as PID 1 with ```start-fg``` and ```/dev/log``` is redirected to stdout.

Usage Example
-------------

This image is intended to be a base image for your projects, so you may use it like this:

```Dockerfile
FROM cosmomill/alpine-postfix

COPY ./main.cf /etc/postfix/
COPY ./master.cf /etc/postfix/
```

```sh
$ docker build -t my_app .
```
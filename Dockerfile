FROM alpine

MAINTAINER Rene Kanzler, me at renekanzler dot com

# add bash to make sure our scripts will run smoothly
RUN apk --update add --no-cache bash

# install socat to fake syslog
RUN apk --update add --no-cache socat

RUN mkdir /docker-entrypoint-init.d

# /etc/aliases should be available at postfix installation.
COPY ./aliases /etc/aliases

# install postfix
RUN apk --update add --no-cache \
	postfix \
	postfix-pcre

# define mountable directories
VOLUME /var/spool/postfix

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 25 465 587
CMD ["start-fg"]
FROM ubuntu:14.04
MAINTAINER Eloy Coto <eloy.coto@gmail.com>

RUN apt-get update
RUN apt-get install -y nginx

ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
WORKDIR /etc/nginx

CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]

FROM ubuntu:latest
COPY .  /var/www/html/
RUN apt-get update && apt-get install -y nginx
CMD [ "nginx", "-g", "daemon off;" ]

#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM ubuntu:14.04

# Install add-apt-repository
RUN \
  apt-get update && \
  apt-get install -y software-properties-common

# Install Nginx.  
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx && \
  apt-get install -y php5-fpm 

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

#FROM orchardup/php5
ADD wordpress/ /var/www/html
ADD config/nginx-sites-available-default /etc/nginx/sites-available/default

# Define default command.
CMD ["/usr/sbin/nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443

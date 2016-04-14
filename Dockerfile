
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
  apt-get install -y software-properties-common php5-fpm && \
  apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/usr/share/nginx/html"]

# Define working directory.
WORKDIR /etc/nginx

#FROM orchardup/php5
ADD wordpress/ /usr/share/nginx/html
ADD config/nginx-sites-available-default /etc/nginx/sites-available/default

# Change owner
RUN \
  chown -R www-data:www-data /usr/share/nginx/html

# Define default command.
CMD ["/usr/sbin/nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
EXPOSE 9000

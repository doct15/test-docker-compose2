
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
  apt-get install -y software-properties-common php5-fpm php5-mysql php5-cli php5-mcrypt&& \
  apt-get install -y nginx
#  chown -R www-data:www-data /var/lib/nginx

# tweak nginx config
RUN sed -i -e"s/worker_processes  1/worker_processes 5/" /etc/nginx/nginx.conf && \
sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf && \
sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf && \
echo "daemon off;" >> /etc/nginx/nginx.conf
# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/usr/share/nginx/html"]

# tweak php-fpm config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini && \
sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini && \
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini && \
sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/pm.max_children = 5/pm.max_children = 9/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" /etc/php5/fpm/pool.d/www.conf && \
sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" /etc/php5/fpm/pool.d/www.conf

# fix ownership of sock file for php-fpm
RUN sed -i -e "s/;listen.mode = 0660/listen.mode = 0750/g" /etc/php5/fpm/pool.d/www.conf && \
find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# mycrypt conf
RUN php5enmod mcrypt

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
#EXPOSE 9000

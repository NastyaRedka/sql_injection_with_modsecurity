# Use the official PHP image with Apache
FROM php:8.0-apache

# Update system packages and install necessary dependencies
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    sqlite3 \
    libapache2-mod-security2 \
    libapr1-dev \
    libaprutil1-dev \
    libpcre3-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_sqlite

# Install and configure ModSecurity
RUN apt-get install -y libapache2-mod-security2
RUN a2enmod security2

# Copy ModSecurity configuration
COPY modsecurity.conf /etc/apache2/mods-enabled/security2.conf

# Enable PHP to parse .html files
RUN echo "AddType application/x-httpd-php .html" >> /etc/apache2/apache2.conf

# Copy the current directory (where the Dockerfile is located) to /var/www/html in the container
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Set file permissions
RUN chown -R www-data:www-data /var/www/html

# Fix permissions for docker-php-entrypoint
RUN chmod 755 /usr/local/bin/docker-php-entrypoint

EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]# Use the official PHP image with Apache
FROM php:8.0-apache

# Update system packages and install necessary dependencies
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    sqlite3 \
    libapache2-mod-security2 \
    libapr1-dev \
    libaprutil1-dev \
    libpcre3-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_sqlite

# Install and configure ModSecurity
RUN apt-get install -y libapache2-mod-security2
RUN a2enmod security2

# Copy ModSecurity configuration
COPY modsecurity.conf /etc/apache2/mods-enabled/security2.conf

# Enable PHP to parse .html files
RUN echo "AddType application/x-httpd-php .html" >> /etc/apache2/apache2.conf

# Copy the current directory (where the Dockerfile is located) to /var/www/html in the container
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Set file permissions
RUN chown -R www-data:www-data /var/www/html

# Fix permissions for docker-php-entrypoint
RUN chmod 755 /usr/local/bin/docker-php-entrypoint

EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]
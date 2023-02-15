#!/bin/bash

echo Instalar PHP
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install php8.1 -y
sudo apt install php8.1-common php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl -y
sudo apt-get install php8.1-pgsql -y
php -v

echo Instalar Apache2
sudo apt-get update
sudo apt-get install apache2 -y

echo Configurar conexion a PostgreSQL
sudo apt-get update
sudo apt-get install postgresql-client -y
wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem
psql --host=postgres-fs.postgres.database.azure.com --port=5432 --username=postgresadmin --dbname=drupal --set=sslmode=require --set=sslrootcert=DigiCertGlobalRootCA.crt.pem

echo Instalar Drupal
cd /var/www/html/
sudo wget --content-disposition https://www.drupal.org/download-latest/tar.gz
sudo tar xf drupal-10.0.3.tar.gz
sudo mv drupal-10.0.3 azuredrupal
sudo chown -R www-data:www-data /var/www/html/azuredrupal/
sudo a2enmod expires headers rewrite
sudo vim /etc/apache2/conf-available/drupal.conf
sudo a2enconf drupal
sudo systemctl restart apache2
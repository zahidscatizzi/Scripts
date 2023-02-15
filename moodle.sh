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
psql --host=postgres-fs.postgres.database.azure.com --port=5432 --username=postgresadmin --dbname=moodle --set=sslmode=require --set=sslrootcert=DigiCertGlobalRootCA.crt.pem

echo Instalar Moodle
cd /var/www/html/
sudo git clone -b MOODLE_401_STABLE git://git.moodle.org/moodle.git
sudo mv moodle azuremoodle
cd
sudo chown -R root /var/www/html/azuremoodle/
sudo chmod -R 755 /var/www/html/azuremoodle/
sudo mkdir /var/www/moodledata
sudo chmod 777 /var/www/moodledata
sudo vim /etc/php/8.1/apache2/php.ini
sudo systemctl restart apache2

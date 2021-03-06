#!/usr/bin/env bash

# Force user to run this script with sudo.
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

echo "                      _     _                   _     "
echo " _ __  _ __ _____   _(_)___(_) ___  _ __    ___| |__  "
echo "| '_ \| '__/ _ \ \ / / / __| |/ _ \| '_ \  / __| '_ \\ "
echo "| |_) | | | (_) \ V /| \__ \ | (_) | | | |_\__ \ | | |"
echo "| .__/|_|  \___/ \_/ |_|___/_|\___/|_| |_(_)___/_| |_|"
echo "|_|"
echo

# Settings
MY_USER="$(logname)"
echo "Running as: $MY_USER, with sudo privileges."

echo

echo "Please type in your desired MariaDB user:"
read MYSQL_USER
echo "Please type in your desired MariaDB password:"
read -s MYSQL_PASS

# echo "MariaDB $MYSQL_USER:$MYSQL_PASS"

# Update package list
apt-get update

# Update system packages
apt-get -y upgrade

# Install some PPAs
apt-get install -y software-properties-common curl
apt-add-repository ppa:nginx/development -y
apt-add-repository ppa:chris-lea/redis-server -y
apt-add-repository ppa:ondrej/php -y
curl --silent --location https://deb.nodesource.com/setup_6.x | bash -

# Update package lists
apt-get update

# Install some basic packages
apt-get install -y dos2unix git libmcrypt4 \
libpcre3 python2.7 python-pip supervisor

# Set your timezone (UTC).
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Install PHP stuffs
apt-get install -y --force-yes php7.2-cli php7.2 \
php7.2-pgsql php7.2-sqlite3 php7.2-gd \
php7.2-curl php7.2-memcached \
php7.2-imap php7.2-mysql php7.2-mbstring \
php7.2-xml php7.2-zip php7.2-bcmath php7.2-soap \
php7.2-intl php7.2-readline \

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install Apache
apt-get install -y --force-yes apache2

# Add your user to www-data
usermod -a -G www-data $MY_USER
id $MY_USER
groups $MY_USER

# Transfer ownership of /var/www to your user
sudo chown -R $MY_USER:www-data /var/www
sudo chmod -R g+s /var/www

# Install Node and some Node packages
apt-get install -y nodejs
/usr/bin/npm install -g gulp
/usr/bin/npm install -g bower
/usr/bin/npm install -g yarn
/usr/bin/npm install -g grunt-cli

# Install MariaDB
apt-get install -y mariadb-server mariadb-client

# Configure MariaDB Remote Access
# sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# mysql --user="root" --password="" -e "GRANT ALL ON *.* TO root@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
# service mysql restart

# Creates a new MySQL/MariaDB user using the provided credentials.
# This is done to avoid using root for database operations.
mysql --user="root" --password="" -e "CREATE USER '$MYSQL_USER'@'0.0.0.0' IDENTIFIED BY '$MYSQL_PASS';"
mysql --user="root" --password="" -e "GRANT ALL ON *.* TO '$MYSQL_USER'@'0.0.0.0' IDENTIFIED BY '$MYSQL_PASS' WITH GRANT OPTION;"
mysql --user="root" --password="" -e "GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS' WITH GRANT OPTION;"
mysql --user="root" --password="" -e "FLUSH PRIVILEGES;"
service mysql restart

# Install a few other things
apt-get install -y redis-server memcached beanstalkd

# Configure Beanstalkd
sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd
/etc/init.d/beanstalkd start

# Configure Supervisor
systemctl enable supervisor.service
service supervisor start

# Install Certbot
wget https://dl.eff.org/certbot-auto -P /opt/certbot
chmod +x /opt/certbot/certbot-auto

# Clean up
apt-get -y autoremove
apt-get -y clean

# Done!
echo " ____                   _ "
echo "|  _ \  ___  _ __   ___| |"
echo "| | | |/ _ \| '_ \ / _ \ |"
echo "| |_| | (_) | | | |  __/_|"
echo "|____/ \___/|_| |_|\___(_)"

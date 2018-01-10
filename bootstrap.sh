#!/usr/bin/env bash

echo 'adding swap file'
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

echo 'updating system'
sudo apt-get update
sudo apt-get upgrade -y

echo 'install development environment'
# apache
sudo apt-get install -y apache2
# php
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get install software-properties-common
sudo apt-get update
sudo apt-get install -y php7.1
sudo apt-get install -y php7.1-mbstring
sudo apt-get install -y php7.1-mcrypt
sudo apt-get install -y php7.1-mysql
sudo apt-get install -y php7.1-xml
sudo apt-get install -y php7.1-zip
sudo apt-get install -y php7.1-cli
sudo apt-get install -y php7.1-json
sudo apt-get install -y php7.1-curl
sudo apt-get install -y php7.1-gd
sudo apt-get install -y php7.1-gmp
sudo apt-get install -y libapache2-mod-php
sudo a2enmod rewrite
sudo service apache2 restart
# nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
# composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
# gulp
sudo npm install gulp-cli -g
# mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt install -y mysql-server
sudo apt install -y mysql-client
sudo apt install -y libmysqlclient-dev
# mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo service mongod start

echo 'done, all set'

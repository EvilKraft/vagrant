#!/usr/bin/env bash


# Disable firewalld
systemctl stop firewalld

systemctl disable firewalld

# log dir
cd /home/vagrant

mkdir log

chmod -R 777 log


# sendmail dir
mkdir sendmail

chmod -R 777 sendmail


# set permissions
chmod -R 777 /home/vagrant

chown -R vagrant:vagrant /home/vagrant


# set local resources
echo "" >> /etc/hosts

echo "# CinnamonCoffee" >> /etc/hosts

echo "10.66.140.253		gitlab" >> /etc/hosts

echo "" >> /etc/hosts

echo "# C4S" >> /etc/hosts

echo "10.200.30.183		code.c4s" >> /etc/hosts


# yum clean cache
yum clean all


# Install repos: EPEL, WebTatic
yum install -y epel-release
yum install -y https://mirror.webtatic.com/yum/el7/webtatic-release.rpm


# Common packages
yum install -y deltarpm yum-cron mlocate mc wget ftp zip unzip vim-enhanced nano bash-completion uuid bind-utils gcc cpp


# apache
yum install -y httpd

usermod -aG vagrant apache

systemctl enable httpd.service


# mysql
yum install -y mariadb-server mariadb

systemctl enable mariadb.service


# php56
yum install -y php56w php56w-opcache php56w-mysql php56w-gd php56w-common php56w-mcrypt php56w-mbstring php56w-pecl-imagick php56w-soap php56w-xml php56w-xmlrpc


# composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer


# phpMyAdmin
yum install -y phpmyadmin


# vsftpd
yum install -y vsftpd

systemctl enable vsftpd.service


# Ruby
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
touch ~/.gemrc
echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
curl -sSL https://get.rvm.io | bash -s stable --rails


# Git
yum -y install zlib-devel perl-CPAN gettext curl-devel expat-devel gettext-devel openssl-devel pcre tk tk-devel
wget https://github.com/git/git/archive/v2.6.0.tar.gz -P /home/vagrant
tar xzfv /home/vagrant/v2.6.0.tar.gz
cd /home/vagrant/git-2.6.0
make prefix=/usr all
make prefix=/usr install
rm -rf /home/vagrant/git-2.6.0
rm -f /home/vagrant/v2.6.0.tar.gz
cd -


# configs
cp /vagrant/extra/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf

cp /vagrant/extra/config.inc.php /etc/phpMyAdmin/config.inc.php

cp /vagrant/extra/php.ini /etc/php.ini

cp /vagrant/extra/httpd.conf /etc/httpd/conf/httpd.conf

cp /vagrant/extra/config /etc/selinux/config

cp /vagrant/extra/example.conf /etc/httpd/conf.d/example.conf

cp /vagrant/extra/localhost.conf /etc/httpd/conf.d/localhost.conf

cp /vagrant/extra/welcome.conf /etc/httpd/conf.d/welcome.conf

cp /vagrant/extra/fake_sendmail.sh /usr/bin/fake_sendmail.sh

chmod +x /usr/bin/fake_sendmail.sh


# timezone
rm -rf /etc/localtime

ln -s /usr/share/zoneinfo/Asia/Tbilisi /etc/localtime


# reboot to disable SELinux
echo "Run \"vagrant reload\" to apply changes..."
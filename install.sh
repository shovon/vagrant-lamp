apt-get update

# Install apache

apt-get install apache2 -y

# Install MySQL

echo "mysql-server mysql-server/root_password select root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again select root" | debconf-set-selections

apt-get -y install mysql-server

mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"

restart mysql

echo "create database development;" | mysql -uroot -proot

cat /vagrant/my.cnf > /etc/mysql/my.cnf

restart mysql

# Install PHP

apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
cat /vagrant/dir.conf > /etc/apache2/mods-enabled/dir.conf

apt-get install -y php5-mysql php5-curl php5-dbg php5-dev php5-gmp php5-json php5-odbc php5-imagick php5-intl php5-mcrypt php5-xdebug

# Share the `public` folder with the virtual machine instance.

rm -r /var/www/html
ln -s /vagrant/public /var/www/html

# Restart Apache for good measures

/etc/init.d/apache2 restart
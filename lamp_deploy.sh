#!/bin/bash -x

#script must be run by the root user. uncomment relevant sections depending on distribution service handling

#check for root user
if [ `id -u` -ne 0 ]; then
	echo "This script must be run by the root user."
	exit 2
fi

if [ "`lsb_release -is`" == "Fedora" ]
	then
		
		dnf install -y httpd community-mysql mysql-devel;
		dnf install -y php phpmyadmin mcrypt;
		dnf install -y tinyxml libzip;
		
		chmod 755 -R /var/www;
		
		printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php
		
		#Systemd
		#systemctl start httpd.service;
		#systemctl restart mysqld.service;
		
		#init.d
		#service httpd start;
		#service mysqld start;

		chkconfig httpd on;
		chkconfig mysqld on;



elif [ "`lsb_release -is`" == "Ubuntu"] || [ "`lsb_relase -is`" == "Debian" ]
	then
		apt-get install apache2;
		apt-get install mysql-server;
		apt-get install php5 libapache2-mod-php5 php5-mysql php5-mcrypt php5-cgi;

		chmod 755 -R /var/www

		printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php 

		#systemd
		#systemctl start apache2.service;
		#systemctl start mysqld.service;

		#init.d
		#service apache2 start;
		#service mysqld start;

		chkconfig apache2 on;
		chkconfig mysqld on;



elif [ "`lsb_release -is`" == "RedHat" ] || [ "`lsb_release -is`" == "CentOS" ]
	then
		
		yum install -y httpd mysql-server mysql-devel;
		yum install -y php php-mysql php-fpm php-devel;
		yum install -y tinyxml libzip;

		chmod 755 -R /var/www

		printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php
		
		#systemd
		#systemctl start httpd.service
		#systemctl start mysqld.service

		#init.d
		#service http start
		#service mysqld start
		
		chkconfig httpd on
		chkconfig mysqld on


fi

else



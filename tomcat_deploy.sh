#!/bin/bash +x

#this script will install a tomcat instance on a centos7 or RHEL7 installation

#check for root user
if [ `id -u` -ne 0 ]; then
	echo "This script must be run by the root user."
	exit 2
fi
#check for os version
if [ "`lsb_release -is`" == "RedHat" ] || [ "`lsb_release -is`" == "CentOS" ]
	then
		yum install -y tomcat
		
		#set tomcat.conf for Tomcat memory usage
		echo "Please set the Xmx variable (Size in m): "
		read XMX
		echo "Please set the MaxPermSize variable (Size in m): "
		read MAXPERMSZ
		echo "#Add JAVA_OPTS options for Tomcat memory use" >> /usr/share/tomcat/conf/tomcat.conf
		echo "JAVA_OPTS="\""-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx${XMX} -MaxPermSize=${MAXPERMSZ} -XX:+UseConcMarkSweepGC\"" >> /usr/share/tomcat/conf/tomcat.conf

		#install the tomcat admin tools
		yum install -y tomcat-webapps tomcat-admin-webapps

		#check documentation preference
		echo "Would you like to install the Tomcat online documentation? (yes or no) "
		read DOCANSWER
			if [ ${DOCANSWER} == "yes" ] || [ ${DOCANSWER} == "y" ]
				then 
					yum install -y tomcat-docs-webapp tomcat-javadoc
			fi


		#define users in the tomcat-users.xml file
		#loop to define the amount of users to add


		#start and enable the tomcat service
		systemctl start tomcat
		systemctl enable tomcat


		#open a browser to check for functionality
		echo "Would you like to open a browser to verify the server is running? (yes or no): "
		read WEBANSWER
			if [ ${WEBANSWER} == "yes" ] || [ ${WEBANSWER} == "y" ]
					then
						python -mwebbrowser http://127.0.0.1:8080
			fi

		echo "Installation Complete"
fi 
echo "This is not a supported operating system"
exit 1

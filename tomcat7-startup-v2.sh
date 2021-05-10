#!/bin/sh
#font: https://geeksterminal.com/automatically-start-tomcat-service-on-boot/1112/
####################################################################
# Created by: Abhijit Sandhan
# Purpose: Start/Stop/Restart Apache Tomcat service
####################################################################
# Check the path of Tomcat and set environment variables as follows
# in the .bashrc profile
export CATALINA_HOME="/opt/tomcat7_prod"
export CATALINA_BASE="/opt/tomcat7_prod"
export JAVA_HOME="/opt/Java/jdk1.8.0_231"
export JAVA_HOME=/opt/Java/jdk1.8.0_231
 
#Use Case statement to start / stop /reset tomcat service
case $1 in
	start)
		sh $CATALINA_HOME/bin/startup.sh
		;;
	stop)
		sh $CATALINA_HOME/bin/shutdown.sh
		;;
	restart)
		sh $CATALINA_HOME/bin/shutdown.sh
		sh $CATALINA_HOME/bin/startup.sh
		;;
esac
exit 0

# ativar servico
# cp tomcat /etc/init.d/
# sudo ln -s /etc/init.d/tomcat /etc/rc2.d/S99tomcat
# chkconfig tomcat on
# chkconfig --list tomcat on
# systemctl enable tomcat
# systemctl status tomcat

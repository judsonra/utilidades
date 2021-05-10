#!/bin/bash
# chkconfig: 2345 80 20
export CATALINA_HOME="/opt/tomcat-7.0.55"
ERROR=0
case "$1" in
 start)
            echo $"Starting Tomcat"
            sh $CATALINA_HOME/bin/startup.sh
            ;;
 stop)
           echo $"Stopping Tomcat"
           sh $CATALINA_HOME/bin/shutdown.sh
           ;;
 restart)
           sh $CATALINA_HOME/bin/shutdown.sh
           sh $CATALINA_HOME/bin/startup.sh
            ;;
 *)
         echo $"Usage: $0 {start|stop|restart}"
 exit 1
 ;;
esac

exit $ERROR

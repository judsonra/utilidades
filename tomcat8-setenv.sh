#font: https://gist.github.com/patmandenver/cadb5f3eb567a439ec01
#
# Cutom Environment Variables for Tomcat
#
############################################
export JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre
export PATH=${JAVA_HOME}/bin:${PATH}

############################################
#
# JAVA_OPTS
#  You could do all this in one export command
# But I am going to be long winded and explain
# Why and add links
#
# Oracle Notes
#  - https://docs.oracle.com/javase/8/docs/technotes/tools/windows/java.html
#  - A good visual
#  https://redstack.wordpress.com/2011/01/06/visualising-garbage-collection-in-the-jvm/
#############################################


# -server
#  Select the java HotSpot Server JVM
# The 64-bit version of the JDK support only the Server VM,
# so in that case the option is implicit
# ... so it's redundant to today's world but it make me feel good.
export JAVA_OPTS="-server"

# -Xms/Xmx
#   Xms Sets the initial size of the Heap
#   Xmx sets the Maximum size of the Heap.
#  http://stackoverflow.com/questions/16087153/what-happens-when-we-set-xmx-and-xms-equal-size
#  http://crunchify.com/jvm-tuning-heapsize-stacksize-garbage-collection-fundamental/
export JAVA_OPTS="$JAVA_OPTS -Xms1024M -Xmx1024M"

# -NewSize/MaxNewSize
#  Set the size of the young generation
#  Most newly created objects are made here
#  Objects taht did not become unreachbale and survice the young
# Generation heap are copied to the Old Generation
# See http://www.cubrid.org/blog/dev-platform/understanding-java-garbage-collection
# https://redstack.wordpress.com/2011/01/06/visualising-garbage-collection-in-the-jvm/
export JAVA_OPTS="$JAVA_OPTS -XX:NewSize=512m -XX:MaxNewSize=512m"

# -PermSize/MaxPermSize
#  Store classes and interned character strings
# http://stackoverflow.com/questions/12114174/what-does-xxmaxpermsize-do
#   Warning!
#  Decprecated in Java 8!!  replace -XX:MetaspaceSize  !!!
export JAVA_OPTS="$JAVA_OPTS -XX:PermSize=256m -XX:MaxPermSize=256m"

# -UseConcMarkSweepGC
#  Also called the low latency GC since pausing time is very short
# When this is enabled it also enabled
#   -XX:+UseParNewGC Potentially speed up your generation GC
#   by a factor equal to the number of CPUS
#   (see http://stackoverflow.com/questions/2101518/difference-between-xxuseparallelgc-and-xxuseparnewgc)
#  http://www.cubrid.org/blog/dev-platform/understanding-java-garbage-collection/
export JAVA_OPTS="$JAVA_OPTS -XX:+UseConcMarkSweepGC"

# -XX:+CMSIncrementalMode
#
#  I am not going to set this one but it's worthe mentioning
# It has been deprecated in Java 8.  It is useful when you have 1 or 2
# CPU machine.  It helps reduce latency by doing smaller garbage collections
#  see thies sites for details
#   http://www.fixdeveloper.com/2014/03/jvm-tuning-cmsincrementalmode-overrides.html
#   http://www.oracle.com/technetwork/java/javase/gc-tuning-6-140523.html#icms


# -CMSClassUnloadingEnabled
#   In an old school java program classes are forever.  But with
# Modern languages like Groovy... Classes are created at runtime, every
# scirpt may create a few new classes.  With this set the PermGen space will
# Be garbage collecte3d.  Without this you have a memory Leak.
#
#  Must also have UseConcMarkSweepGC set for this to work.
#
#  http://stackoverflow.com/questions/3334911/what-does-jvm-flag-cmsclassunloadingenabled-actually-do
export JAVA_OPTS="$JAVA_OPTS -XX:+CMSClassUnloadingEnabled"


# -DisableExlicitGC
#  Explicit calls to System.gc() are completely ignored
#
# http://stackoverflow.com/questions/12847151/setting-xxdisableexplicitgc-in-production-what-could-go-wrong
export JAVA_OPTS="$JAVA_OPTS -XX:+DisableExplicitGC"

# -HeapDumpPath
#   Set the file where the heap dump will write out its error
export JAVA_OPTS="$JAVA_OPTS -XX:HeapDumpPath=/10x13/logs/tomcat8/java_heapdump_pid_%p.log"

# -java.awt.headless
#  Basically tell the JVM not to load awt libraries
#  Your server is not a desktop app, there is more to this rule than that.
#  If you want to go into it check out.
#  https://blog.idrsolutions.com/2013/08/what-is-headless-mode-in-java/
#  http://www.oracle.com/technetwork/articles/javase/headless-136834.html
export JAVA_OPTS="$JAVA_OPTS -Djava.awt.headless=true"


# -java.security.egd
#  This one is abit of a debate
# If you don't set this it will use /dev/random on startup
# which can block and make tomcat startup slower.
# But it's technically more secure... but no one has shown
# a way to break the results of urandom which is faster.
#  For more details see.
#   http://www.2uo.de/myths-about-urandom/
export JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"

#################################################
# CATALINA_OPTS
# This are basically JAVA_OPTS but only used by tomcat
# and only run on Tomcat start see
#  http://stackoverflow.com/questions/11222365/catalina-opts-vs-java-opts-what-is-the-difference
# for more details
#
################################################


# -jmcremot..
# Turn onthe jmxremote so you can use JConsole or VisualVM
#  to monito the jvm remotely
#  See
#     https://tomcat.apache.org/tomcat-7.0-doc/monitoring.html
#     http://www.mkyong.com/tomcat/jconsole-jmx-remote-access-on-tomcat/
#     http://www.javaworld.com/article/2072322/from-jconsole-to-visualvm.html
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.port=9090"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.ssl=false"
#This gets the local IP address
IP_ADDR=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
export CATALINA_OPTS="$CATALINA_OPTS -Djava.rmi.server.hostname=$IP_ADDR"



export CATALINA_HOME=/10x13/apps/tomcat8
export CATALINA_OUT=/10x13/logs/tomcat8/catalina.out
export CATALINA_PID=/var/run/tomcat8/tomcat.pid

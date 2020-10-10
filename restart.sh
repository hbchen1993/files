#!/bin/sh

tomcat_dirname=$(cd "$(dirname "$0")"; pwd)
#tomcat_dirname=`cd .. ; pwd`

pid=`ps -ef| grep ${tomcat_dirname}| grep -v "grep"| awk '{print $2}'`

if [ -n "${pid}" ];then
    echo "Will shutdown Tomcat: ${pid}"
    kill -9 ${pid}
    sleep 2
    sh ${tomcat_dirname}/startup.sh
 
    new_pid=`ps -ef| grep ${tomcat_dirname}| grep -v "grep"| awk '{print $2}'`
 
    if [ -n "${new_pid}" ];then
        echo "Tomcat has been started.The new pid is ${new_pid}!"
        sleep 2
        #tail -f ${tomcat_dirname}/logs/catalina.out
    else
        echo "Tomcat did not start!" 
    fi
else
    echo "No Tomcat process! Start in 3 seconds"
    sleep 3    
    sh ${tomcat_dirname}/startup.sh
    #tail -f ${tomcat_dirname}/logs/catalina.out
fi

#!/bin/sh
cp /etc/hosts /etc/hosts.temp
sed -i "s/.*$(hostname)/$DOCKER_IP $(hostname)/" /etc/hosts.temp
cat /etc/hosts.temp > /etc/hosts
/opt/tomcat/bin/startup.sh
tail -f /opt/tomcat/logs/catalina.out
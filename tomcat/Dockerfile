FROM 10.161.160.23:5000/centos-jdk:6.8

# Install prepare infrastructure
RUN yum -y update && \
	yum -y install wget && \
	yum -y install tar 

# Prepare environment 
ENV CATALINA_HOME /opt/tomcat

# Install Tomcat

RUN wget http://mirrors.hust.edu.cn/apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz && \
	tar -xvf apache-tomcat-7.0.73.tar.gz && \
	rm apache-tomcat*.tar.gz && \
	mv apache-tomcat* /opt/tomcat 

ADD server.xml /opt/tomcat/conf/server.xml
ADD catalina.sh /opt/tomcat/bin/catalina.sh
ADD start.sh /opt/tomcat/bin/start.sh

RUN chmod +x /opt/tomcat/bin/*sh

RUN mkdir -p /opt/scmcloud-config

WORKDIR /opt/tomcat

VOLUME /opt/tomcat/webapps
VOLUME /opt/tomcat/logs

EXPOSE 8080
EXPOSE 8009

CMD /opt/tomcat/bin/start.sh

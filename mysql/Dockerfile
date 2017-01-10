FROM 10.161.160.23:5000/centos:6.8
MAINTAINER dwys0343 "dwys0343@sina.com"
 
RUN yum install -y mysql-server mysql
 
RUN /etc/init.d/mysqld start &&\
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by 'root';"&&\
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by 'root';"&&\
    mysql -u root -proot -e "show databases;"
 
EXPOSE 3306
 
CMD ["/usr/bin/mysqld_safe"]


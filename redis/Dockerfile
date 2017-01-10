FROM 10.161.160.23:5000/centos-jdk:6.8

# Maintener
MAINTAINER Wei Feng <weifeng@yhd.com>

RUN yum -y update && \
        yum -y install wget && \
        yum -y install tar && \
	yum -y install gcc

# Install redis
RUN wget http://download.redis.io/releases/redis-3.2.6.tar.gz && \
    tar -zxvf redis-3.2.6.tar.gz && \
    cd redis-3.2.6 && \
    make && \
    mkdir /usr/redis && \
    cp src/redis-server /usr/redis/  && \
    cp src/redis-cli /usr/redis/

ADD redis.conf /etc/redis.conf

# User
USER root

# Set the environment variables
ENV HOME /usr/redis

# Working directory
WORKDIR /usr/redis

CMD ["/usr/redis/redis-server","/etc/redis.conf"]

# Expose ports.
EXPOSE 6379


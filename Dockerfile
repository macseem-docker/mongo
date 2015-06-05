FROM debian:7.7
MAINTAINER Max D. <lugamax@gmail.com>


RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 \
     && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" \
       | tee /etc/apt/sources.list.d/mongodb-org-3.0.list \
     && apt-get update \
     && apt-get install -y -q procps adduser mongodb-org 

ADD  mongo_init.js /root/mongo_init.js
ADD  mongo_init.sh /root/mongo_init.sh
ADD  mongod_noauth.conf /etc/mongod_noauth.conf
ADD mongod.conf /etc/mongod.conf

RUN /root/mongo_init.sh
ADD init.sh /init.sh

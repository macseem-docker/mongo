FROM debian:7.7
MAINTAINER Max D. <lugamax@gmail.com>

RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 \
     && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" \
       | tee /etc/apt/sources.list.d/mongodb-org-3.0.list \
     && apt-get update \
     && apt-get install -y -q adduser mongodb-org
ADD mongod.conf /etc/mongod.conf
ADD init.sh /init.sh

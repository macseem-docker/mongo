#!/bin/bash
chown -R mongodb.mongodb /var/lib/mongodb
/usr/bin/mongod --config /etc/mongod.conf


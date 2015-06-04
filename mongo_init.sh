  FILE="/root/mongo_init.js"
  PIDFILE="/var/run/mongod.pid"
  CONFIGFILE="/etc/mongod.conf"
  MONGOUSER="mongodb"
  DAEMONARGS="--noauth --config $CONFIGFILE"
  #service mongod start&
  start-stop-daemon --background --start --quiet --pidfile $PIDFILE \
                          --make-pidfile --chuid $MONGOUSER \
                                                  --exec /usr/bin/mongod -- $DAEMONARGS &

#  start-stop-daemon --start --exec mongod --config $CONFIGFILE --noauth --make-pidfile $PIDFILE & 
    echo 'Waiting for mongo to come online'
    while [ ! -f $PIDFILE ]; do
        sleep 1
    done
 
  mongo admin $FILE
  start-stop-daemon --stop --pidfile $PIDFILE --user $MONGOUSER

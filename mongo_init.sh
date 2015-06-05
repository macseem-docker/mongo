  FILE="/root/mongo_init.js"
  PIDFILE="/var/run/mongod.pid"
  NOAUTHCONFIGFILE="/etc/mongod_noauth.conf"
  MONGOUSER="mongodb"
  DAEMON="/usr/bin/mongod"
  #service mongod start&
  rm /var/lib/mongodb/mongod.lock
  start-stop-daemon -Sbvx /usr/bin/mongod -p /var/run/mongod.pid \
     --make-pidfile --chuid mongodb -- --config /etc/mongod_noauth.conf
#  start-stop-daemon --background --start --quiet \
#                            --pidfile $PIDFILE \
#                            --make-pidfile --chuid $MONGOUSER \
#                            --exec /usr/bin/mongod \
#                            -- --config $NOAUTHCONFIGFILE 

#  start-stop-daemon --start --exec mongod --config $CONFIGFILE --noauth --make-pidfile $PIDFILE & 
running_pid() {
# Check if a given process pid's cmdline matches a given name
    pid=$1
    name=$2
    [ -z "$pid" ] && return 1
    [ ! -d /proc/$pid ] &&  return 1
    cmd=`cat /proc/$pid/cmdline | tr "\000" "\n"|head -n 1 |cut -d : -f 1`
    # Is this the expected server
    [ "$cmd" != "$name" ] &&  return 1
    return 0
}

running() {
# Check if the process is running looking at /proc
# (works for all users)

    # No pidfile, probably no daemon present
    [ ! -f "$PIDFILE" ] && return 1
    pid=`cat $PIDFILE`
    running_pid $pid $DAEMON || return 1
    return 0
}

    echo 'Waiting for mongo to come online'
    while [ ! running ] ; do
        sleep 1
    done
 
  mongo admin $FILE
  start-stop-daemon --stop --pidfile $PIDFILE --user $MONGOUSER

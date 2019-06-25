#!/bin/sh

# Enter the FQDNs you want to check with ping (space separated)
# Script does nothing if any tries to any FQDN succeeds
FQDN="www.google.com"
#FQDN="$FQDN www.amd.com"
#FQDN="$FQDN www.juniper.net"

# Sleep between ping checks of a FQDN (seconds between pings)
SLEEP=3                         # Sleep time between each retry
RETRY=3                         # Retry each FQDN $RETRY times
SLEEP_MAIN=60                   # Main loop sleep time

check_connection()
{
  for NAME in $FQDN; do
    for i in $(seq 1 $RETRY); do
      ping -c 1 $NAME > /dev/null 2>&1
      if [ $? -eq 0 ]; then
        return 0
      fi
      sleep $SLEEP
    done
  done
  # If we are here, it means all failed
  return 1
}

while true; do
  check_connection
  if [ $? -ne 0 ]; then
    date >> /root/reboot.log
    /etc/init.d/ncm-network start
  fi
  sleep $SLEEP_MAIN
done

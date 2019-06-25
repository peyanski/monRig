#! /bin/sh
# Checks if the wifi conn is up.  If not, it tries to restart
# the wifi.  If that fails, then reboot.
if ping -c 1 8.8.8.8  > /dev/null
then
  echo nothing > /dev/null
else
  /etc/init.d/network restart
  sleep 30
  if ping -c 8.8.8.8 > /dev/null
  then
    echo nothing > /dev/null
  else
    date >> /root/reboot.log
    reboot
  fi
fi

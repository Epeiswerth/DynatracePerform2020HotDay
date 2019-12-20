#!/bin/bash

# Install OpenJDK
apt-get update

# Lets make sure EasyTravel and supporting stuff doesn't exist
if [ -d "/opt/easytravel-2.0.0-x64" ]; then
        echo "EasyTravel found... removing directory..."
        pkill -f CommandlineLauncher
        sleep 20s
        rm -fr /opt/easytravel-2.0.0-x64
	rm -fr "/root/.dynaTrace/easyTravel 2.0.0"
fi

if [ -f "/var/spool/cron/crontabs/root" ]
then
        echo "root crontab found... removing..."
        rm /var/spool/cron/crontabs/root
        update-rc.d cron defaults
fi

if [ -f "/opt/dynatrace-easytravel-linux-x86_64.jar" ]
then
        echo "EasyTravel install file found... removing..."
        #rm /opt/dynatrace-easytravel-linux-x86_64.jar
fi

if [ $(dpkg-query -W -f='${Status}' default-jre 2>/dev/null | grep -c "ok installed") -eq 1 ];
then
  sleep 1s
  echo "."
  echo "Removing default-jre"
  #apt-get remove default-jre -y;
fi

/opt/dynatrace/oneagent/agent
if [ -f "/opt/dynatrace/oneagent/agent/uninstall.sh" ]
then
        echo "OneAgent uninstall file found... Uninstalling the OneAgent..."
        /bin/sh /opt/dynatrace/oneagent/agent/uninstall.sh
	sleep 10s
	rm -fr /opt/dynatrace
	rm /opt/Dynatrace-OneAgent-Linux-1.157.210.sh
fi


sleep 1s
echo "."
sleep 1s
echo "."
sleep 1s
echo "."

#Initiate a reboot
echo "Rebooting the server in 5 seconds"
echo "5"
sleep 1s
echo "4"
sleep 1s
echo "3"
sleep 1s
echo "2"
sleep 1s
echo "1"
sleep 1s
reboot

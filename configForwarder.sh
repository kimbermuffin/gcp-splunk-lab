#!/bin/bash

# Install Splunk Forwarder on VM
wget -O splunkforwarder-7.2.3-06d57c595b80-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.2.3&product=universalforwarder&filename=splunkforwarder-7.2.3-06d57c595b80-linux-2.6-amd64.deb&wget=true'
sudo dpkg -i splunkforwarder-7.2.3-06d57c595b80-linux-2.6-amd64.deb
cd /opt/splunkforwarder/bin/

# Setup commands to forward and monitor directories
ADMIN_PASS=$(sudo ./splunk start --accept-license --answer-yes --no-prompt --gen-and-print-passwd | grep "Randomly generated admin password:" -A1 | tail -n 1)
echo $ADMIN_PASS "IS THE ADMINISTRATOR PASSWORD"

# Need to update automatic IP grab of forward-server
sudo ./splunk add forward-server [X.X.X.X]:9997 -auth admin:$ADMIN_PASS
sudo ./splunk add monitor /var/log/ 

sudo ./splunk restart

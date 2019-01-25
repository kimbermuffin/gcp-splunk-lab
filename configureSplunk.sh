#!/bin/bash
# configureSplunk.sh
# Get and Configure Splunk things!

# Download the Splunk Installer and install it
wget -O splunk-7.2.3-06d57c595b80-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.2.3&product=splunk&filename=splunk-7.2.3-06d57c595b80-linux-2.6-amd64.deb&wget=true'
sudo dpkg -i splunk-7.2.3-06d57c595b80-linux-2.6-amd64.deb
cd /opt/splunk/bin/

# Set up and start Splunk!
ADMIN_PASS=$(sudo ./splunk start --accept-license --answer-yes --no-prompt --gen-and-print-passwd | grep "Randomly generated admin password:" -A1 | tail -n 1)

# Add a line to change time to UTC?


# Enable basic listening on port 9997
sudo ./splunk enable listen 9997 -auth admin:$ADMIN_PASS

# Add line to echo "The instance name is "
echo "The administrator password is " $ADMIN_PASS

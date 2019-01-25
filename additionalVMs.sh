#!/bin/bash
# File to create some kind of VM that'll forward logs to the Splunk that was just created

PROJECT_NAME = ProjectName
ZONE_NAME = ZoneOfProject
FRONTEND_NAME=(frontend-"$RANDOM")
BACKEND_NAME=(backend-"$RANDOM")

# Create backend and config the Splunk forwarder
gcloud compute --project=$PROJECT_NAME instances create $BACKEND_NAME --zone=$ZONE_NAME --machine-type=f1-micro --subnet=default --network-tier=PREMIUM --tags=http-server --image=ubuntu-1404-trusty-v20190110 --image-project=ubuntu-os-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=backend-1
sleep 60
gcloud compute --project "$PROJECT_NAME" ssh --zone "$ZONE_NAME" "$BACKEND_NAME" < ./configForwarder.sh
sleep 90

# Create frontend
gcloud compute --project=$PROJECT_NAME instances create $FRONTEND_NAME --zone=$ZONE_NAME --machine-type=f1-micro --subnet=default --network-tier=PREMIUM --tags=http-server --image=ubuntu-1404-trusty-v20190110 --image-project=ubuntu-os-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=backend-1
sleep 60
gcloud compute --project "$PROJECT_NAME" ssh --zone "$ZONE_NAME" "$FRONTEND_NAME" < ./configForwarder.sh

echo "The VMs "$BACKEND_NAME" and "$FRONTEND_NAME" have successfully been created."

# Google Tutorial VM setups
# sudo nohup nodejs server.js --be_ip 10.142.0.5 --fe_ip 10.142.0.4 &
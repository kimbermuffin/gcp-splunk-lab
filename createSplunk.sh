#!/bin/bash
# createSplunk.sh
# Creation of a Splunk instance on GCP VM Instance
# Assumes gcloud has been configured and new project is set up to create VMs in
# Creates a micro instance for cost savings but can be changed

PROJECT_NAME = ProjectName
ZONE_NAME = ZoneOfProject
SPLUNKINSTANCE_NAME=(splunk-"$RANDOM")

echo "Creating instance " + $SPLUNKINSTANCE_NAME 
gcloud compute --project=$PROJECT_NAME instances create $SPLUNKINSTANCE_NAME --zone=$ZONE_NAME --machine-type=f1-micro --subnet=default --network-tier=PREMIUM --tags splunk-indexer-web-access

gcloud compute --project "$PROJECT_NAME" ssh --zone "$ZONE_NAME" "$SPLUNKINSTANCE_NAME" < ./configureSplunk.sh

# Create all the other stuff 
sleep 90
./addtionalVMs.sh
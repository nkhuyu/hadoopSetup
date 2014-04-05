#!/bin/bash -x

hostname=`hostname`;

./ubuntu/nonHduserUbuntu.sh
scp -r ~/hadoopSetup hduser@$hostname:~/.
ssh hduser@$hostname "~/hadoopSetup/ubuntu/hduserUbuntu.sh"

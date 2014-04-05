#!/bin/bash -x

hostname=`hostname`;

sh ubuntu/nonHduserUbuntu.sh
ssh hduser@$hostname
sh ubuntu/hduserUbuntu.sh

#!/bin/bash -x

hostname=`hostname`;

sh ubuntu/nonHduserUbuntu.sh
ssh hduser@$hostnamesh sh ubuntu/hduserUbuntu.sh

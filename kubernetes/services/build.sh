#!/bin/sh

#find a way to set this up automatically
. ./environment.sh
echo "----"

#./gradlew  -DSME_BE_HOST=$SME_BE_HOST -DDOCKER_REGISTRY=$DOCKER_REGISTRY  buildDocker -x test
echo "Building segmentme-channel-service"
./gradlew  -DSME_BE_HOST=$SME_BE_HOST -DDOCKER_REGISTRY=$DOCKER_REGISTRY  :services:channel-service:buildDocker -x test -Dservice-name=segmentme-channel-service
echo "----"

echo "Building segmentme-analysis-service"
./gradlew  -DSME_BE_HOST=$SME_BE_HOST -DDOCKER_REGISTRY=$DOCKER_REGISTRY  :services:analysis-service:buildDocker -x test -Dservice-name=segmentme-analysis-service
echo "----"

echo "Building segmentme-management-service"
./gradlew  -DSME_BE_HOST=$SME_BE_HOST -DDOCKER_REGISTRY=$DOCKER_REGISTRY  :services:management-service:buildDocker -x test -Dservice-name=segmentme-management-service
echo "----"

echo "Building segmentme-analysis-api-service"
./gradlew  -DSME_BE_HOST=$SME_BE_HOST -DDOCKER_REGISTRY=$DOCKER_REGISTRY  :services:analysis-api-service:buildDocker -x test -Dservice-name=segmentme-analysis-api-service
echo "----"

echo "Building segmentme-measurement-service"
./gradlew  -DSME_BE_HOST=$SME_BE_HOST -DDOCKER_REGISTRY=$DOCKER_REGISTRY  :services:measurement-service:buildDocker -x test -Dservice-name=segmentme-measurement-service
echo "----"

echo "Building segmentme-access-control-service"
./gradlew  -DSME_BE_HOST=$SME_BE_HOST -DDOCKER_REGISTRY=$DOCKER_REGISTRY  :services:access-control-service:buildDocker -x test -Dservice-name=segmentme-access-control-service
echo "----"

#!/bin/sh
. ./environment.sh

echo "----"

aws ecr  --profile sme-vk get-login-password --region us-east-1 | docker login --username AWS --password-stdin $DOCKER_REGISTRY

echo "Publish segmentme-channel-service"
docker push $DOCKER_REGISTRY/segmentme-channel-service:latest
echo "----"

echo "Publish segmentme-analysis-service"
docker push $DOCKER_REGISTRY/segmentme-analysis-service:latest
echo "----"

echo "Publish segmentme-management-service"
docker push $DOCKER_REGISTRY/segmentme-management-service:latest
echo "----"

echo "Publish segmentme-analysis-api-service"
docker push $DOCKER_REGISTRY/segmentme-analysis-api-service:latest
echo "----"

echo "Publish segmentme-measurement-service"
docker push $DOCKER_REGISTRY/segmentme-measurement-service:latest
echo "----"

echo "Publish segmentme-access-control-service"
docker push $DOCKER_REGISTRY/segmentme-access-control-service:latest
echo "----"

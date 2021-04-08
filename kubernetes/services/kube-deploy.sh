#!/bin/sh

$(cat ./environment.sh)
printenv
echo "----"
./kube-create-registry-secrets.sh
echo "----"
echo "Delete access controll service priod new deployment"
kubectl delete deployments access-control-service
echo "Deploy access controll service"

envsubst < access-control-service-deployment.yml | kubectl apply -f -
echo "----"
kubectl get pods

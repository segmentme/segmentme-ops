#!/bin/sh

#waitForDeploymentStart(){
#    echo $1
#    kubectl wait --for=condition=ready pod -l app=$1
#}

waitForDeploymentStart(){
    while [[ $(kubectl get pods -l app=$1 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for pod $1" && sleep 1; done
}
#find a way to set this up automatically
. ./environment.sh
echo "----"
./kube-create-registry-secrets.sh
echo "----"
echo "Delete access controll service"
kubectl delete deployments access-control-service
echo "----"
echo "Delete analysis-service"
kubectl delete analysis-service
echo "----"
echo "Delete analysis-api-service"
kubectl delete analysis-api-service
echo "----"
echo "Delete management-service"
kubectl delete management-service
echo "----"
echo "Delete measurement-service"
kubectl delete measurement-service
echo "----"


echo "Deploy access control service"
name="access-control-service"
envsubst < access-control-service-deployment.yml | kubectl apply -f -
waitForDeploymentStart $name
echo "----"

echo "Deploy analysis service"
name="analysis-service"
envsubst < analysis-service-deployment.yml | kubectl apply -f -
waitForDeploymentStart $name
echo "----"

echo "Deploy analysis API service"
name="analysis-api-service"
envsubst < analysis-api-service-deployment.yml | kubectl apply -f -
waitForDeploymentStart $name
echo "----"


echo "Deploy management service"
name="management-service"
envsubst < management-service-deployment.yml | kubectl apply -f -
waitForDeploymentStart $name
echo "----"


echo "Deploy measurement service"
name="measurement-service"
envsubst < measurement-service-deployment.yml | kubectl apply -f -
waitForDeploymentStart $name
echo "----"

kubectl get pods

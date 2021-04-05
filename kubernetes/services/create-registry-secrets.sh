KUBERNETES_REGISTRY=aws-ecr
DOCKER_ECR=$REPLACE_WITH_DOCKER_REGISTRY
DOCKER_USERNAME=AWS
DOCKER_EMAIL=vak.kondratenko@gmail.com
DOCKER_SECRET=$(aws ecr  --profile sme-vk get-login-password --region us-east-1 | sed -e 's/.*-p //' -e 's/ .*$//')
kubectl delete secrets ${KUBERNETES_REGISTRY} 2> /dev/null
kubectl create secret docker-registry ${KUBERNETES_REGISTRY} \
--docker-server=${DOCKER_ECR} \
--docker-username=${DOCKER_USERNAME} \
--docker-password=${DOCKER_SECRET} \
--docker-email=${DOCKER_EMAIL}

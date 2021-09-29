test -n "$1" && echo REGION is "$1" || "echo REGION is not set && exit"
test -n "$2" && echo account number is "$2" || "echo account number is not set && exit"

helm repo add autoscaler https://kubernetes.github.io/autoscaler
helm repo update
helm install cluster-autoscaler --namespace kube-system autoscaler/cluster-autoscaler --set awsRegion=$1 --set rbac.serviceAccount.annotations."eks\.amazonaws\.com/role-arn"=arn:aws:iam::$2::role/cluster-autoscaler --values cluster-autoscaler-chart-values.yaml
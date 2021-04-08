sh ./build.sh
echo "----"

aws ecr  --profile sme-vk get-login-password --region us-east-1 | docker login --username AWS --password-stdin 925575267836.dkr.ecr.us-east-1.amazonaws.com

echo "Publish segmentme-channel-service"
docker push 925575267836.dkr.ecr.us-east-1.amazonaws.com/segmentme-channel-service:latest
echo "----"

echo "Publish segmentme-analysis-service"
docker push 925575267836.dkr.ecr.us-east-1.amazonaws.com/segmentme-analysis-service:latest
echo "----"

echo "Publish segmentme-management-service"
docker push 925575267836.dkr.ecr.us-east-1.amazonaws.com/segmentme-management-service:latest
echo "----"

echo "Publish segmentme-analysis-api-service"
docker push 925575267836.dkr.ecr.us-east-1.amazonaws.com/segmentme-analysis-api-service:latest
echo "----"

echo "Publish segmentme-measurement-service"
docker push 925575267836.dkr.ecr.us-east-1.amazonaws.com/segmentme-measurement-service:latest
echo "----"

echo "Publish segmentme-access-control-service"
docker push 925575267836.dkr.ecr.us-east-1.amazonaws.com/segmentme-access-control-service:latest
echo "----"

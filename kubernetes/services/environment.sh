echo "Setting up environment variables"
export DOCKER_REGISTRY=925575267836.dkr.ecr.us-east-1.amazonaws.com
export SEGMENTME_DB_CONNECTOR_URI="mongodb://192.168.1.14:27017/test?readPreference=primary&appname=MongoDB%20Compass&ssl=false"
export AUTH0_CLIENT_ID=FRFEhM5zwQCva2tSfBxDuM3og5TdjUpC
export AUTH0_CLIENT_SECRET=Rsic0pW4Wr_q91Ppin-UNRuq5EdH5X7EmhA4ZUTcN-6MBu_Wy8Ce1J89WPCpkD_4
export SME_BE_HOST=http://demo.segmentme.io:8756
export ACCESS_SERVICE_HOST=http://localhost:8085
export ANALYSIS_SERVICE_HOST=http://localhost:8082
export MANAGEMENT_SERVICE_HOST=http://localhost:8084
export CHANNEL_SERVICE_PORT=7777
export CHANNEL_SERVICE_HOST=localhost
echo "Environment variable set"


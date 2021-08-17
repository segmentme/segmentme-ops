echo "Setting up environment variables"
export DOCKER_REGISTRY=925575267836.dkr.ecr.us-east-1.amazonaws.com
#export SEG#MENTME_DB_CONNECTOR_URI="mongodb://192.168.1.14:27017/test?readPreference=primary&appname=MongoDB%20Compass&ssl=false"
export SEGMENTME_DB_CONNECTOR_URI="mongodb+srv://segmentme-connector:segmentme-connector-password@cluster0.knky3.mongodb.net/segmentme?retryWrites=true&w=majority"
export AUTH0_CLIENT_ID=FRFEhM5zwQCva2tSfBxDuM3og5TdjUpC
export AUTH0_CLIENT_SECRET=Rsic0pW4Wr_q91Ppin-UNRuq5EdH5X7EmhA4ZUTcN-6MBu_Wy8Ce1J89WPCpkD_4
export SME_BE_HOST=http://demo.segmentme.io:8756
#export SME_BE_HOST=http://192.168.1.14
export ACCESS_SERVICE_HOST="http://access-control-service"
export ANALYSIS_SERVICE_HOST="http://analysis-service"
export MANAGEMENT_SERVICE_HOST="http://management-service"
export MEASUREMENT_SERVICE_HOST="http://measurement-service"
export CHANNEL_SERVICE_PORT=7777
export CHANNEL_SERVICE_HOST=channel-service
#export REDIS_HOST="192.168.1.14"
export REDIS_HOST="segmentme-demo-redis.favkow.0001.use1.cache.amazonaws.com"
export REDIS_PORT=6379


echo "Environment variable set"


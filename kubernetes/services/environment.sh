echo "Setting up environment variables"
export DOCKER_REGISTRY=925575267836.dkr.ecr.us-east-1.amazonaws.com
export SEGMENTME_DB_CONNECTOR_URI="mongodb://192.168.1.14:27017/test?readPreference=primary&appname=MongoDB%20Compass&ssl=false"
export AUTH0_CLIENT_ID=FRFEhM5zwQCva2tSfBxDuM3og5TdjUpC
export AUTH0_CLIENT_SECRET=Rsic0pW4Wr_q91Ppin-UNRuq5EdH5X7EmhA4ZUTcN-6MBu_Wy8Ce1J89WPCpkD_4

echo "Environment variable set"
printenv
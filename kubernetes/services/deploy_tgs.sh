#!/bin/sh
. ./environment.sh
. ./set_env_vars_from_secret_manager.sh


envsubst < tg-api.yml | kubectl apply -f -
envsubst < tg-web-app.yml | kubectl apply -f -
#!/bin/bash

#curl -sS http://127.0.0.1/service/login

export IMAGE_TAG=timescale/timescaledb:2.3.1-pg11
export SERVICE_NAME=timesaale
docker pull ${IMAGE_TAG}
docker service scale ${SERVICE_NAME}=0
docker service rm ${SERVICE_NAME}
docker service create --replicas 1 \
    --name ${SERVICE_NAME} \
    --publish published=15474,target=5432 \
    --health-cmd='ls' \
    --health-timeout=10s \
    --health-retries=3 \
    --health-interval=5s \
    ${IMAGE_TAG}
    
docker service scale ${SERVICE_NAME}=1

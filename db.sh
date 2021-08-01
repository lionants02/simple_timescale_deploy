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
    --mount type=bind,src=/home/thanachai/timescale/data,dst=/var/lib/postgresql/data/pgdata \
    --env "PGDATA=/var/lib/postgresql/data/pgdata" \
    --env "POSTGRES_USER=xxxxxxx" \
    --env "POSTGRES_PASSWORD=xxxxxxx" \
    --health-cmd='ls' \
    --health-timeout=15s \
    --health-retries=3 \
    --health-interval=5s \
    ${IMAGE_TAG}
    
docker service scale ${SERVICE_NAME}=1

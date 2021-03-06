#!bin/bash

sudo xhost +local:

sudo docker run --entrypoint ./runapp.sh --gpus all -e "ACCEPT_EULA=Y" --network=host \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /etc/localtime:/etc/localtime:ro \
        -v $PWD/job_in_docker:/root/job_in_docker\
        -e DISPLAY=unix${DISPLAY} lottoworld777/lotto-cuda10.2-isaac-sdk-rosmelodic:latest
# job_in_docker is a sharing folder for sharing local files, fodlers, etc..

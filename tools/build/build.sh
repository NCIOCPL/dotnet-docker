#!/bin/sh
# Builds the nciwebcomm/dotnet-docker Runtime and SDK images

# Figure out paths to everything
export SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PROJECT_HOME="$(cd $SCRIPT_PATH/../.. && pwd)"
export CURDIR=`pwd`

export BASENAME=${DOCKER_REGISTRY}/ocpl/dotnet-docker

# Do we have credentials to push the result?
if [ -z "$DOCKER_USERNAME" ]; then echo DOCKER_USERNAME not set; exit 1; fi
if [ -z "$DOCKER_PASSWORD" ]; then echo DOCKER_PASSWORD not set; exit 1; fi
if [ -z "$DOCKER_REGISTRY" ]; then echo DOCKER_REGISTRY not set; exit 1; fi

#
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY


builds=( "sdk" "runtime")
for i in "${builds[@]}"
do
    docker build -f $PROJECT_HOME/$i/Dockerfile -t $BASENAME:$i $i
    eval $SCRIPT_PATH/publish-docker-image.sh $BASENAME $i
done



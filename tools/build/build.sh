#!/bin/sh
# Builds the nciwebcomm/dotnet-docker Runtime and SDK images

# Figure out paths to everything
export SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PROJECT_HOME="$(cd $SCRIPT_PATH/../.. && pwd)"
export CURDIR=`pwd`

export BASENAME=nciwebcomm/dotnet-docker

# Do we have credentials to push the result?
if [ "$DOCKER_USERNAME" == "" ]; then echo DOCKER_USERNAME not set; exit 1; fi
if [ "$DOCKER_PASSWORD" == "" ]; then echo DOCKER_PASSWORD not set; exit 1; fi

#
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD


builds=( "sdk" "runtime")
for i in "${builds[@]}"
do
    docker build -f $PROJECT_HOME/$i/Dockerfile -t $BASENAME:$i $i
    eval $SCRIPT_PATH/publish-docker-image.sh $BASENAME $i
done



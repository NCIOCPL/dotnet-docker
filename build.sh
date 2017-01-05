#!/bin/sh
# Builds the nciwebcomm/dotnet-docker Runtime and SDK images

builds=( "sdk" "runtime")
for i in "${builds[@]}"
do
    docker build -f $i/Dockerfile -t nciwebcomm/dotnet-docker:$i $i
done

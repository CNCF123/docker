#!/bin/sh

#先清理 名称为none的镜像 
docker image prune

IMAGES=$(docker images --format '{{.Repository}}:{{.Tag}}')

for element in ${IMAGES[@]}
do

  echo "saving ${element} ..."
  docker save ${element} >> docker-all-image.tar
  echo "${element} saved"
done

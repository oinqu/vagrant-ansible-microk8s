#!/usr/bin/env bash
set -eux
source ./env/app.env

image="${REGISTRY}/${NAMESPACE}/${DEPLOYMENT}/${NAME}"
# Get build number of the current running image and increase it by one.
# If there isn't any images then build number is 1.
build=$(($(microk8s.ctr i ls | grep ${image}:v${VERSION} | awk '{printf $1}' | awk -F '.' '{printf $NF}') + 1))
tag="v${VERSION}.${build}"

echo "Removing old custom images from microk8s registry"
microk8s.ctr i ls | grep "${image}" | awk '{print $1}' | xargs microk8s.ctr i rm

docker build -t ${image}:${tag} .
docker push ${image}:${tag}
docker rmi $(docker images ${image} -q) -f

echo "export IMAGE=${image}:${tag}" > ./env/build_vars.env

#!/usr/bin/env bash
set -e
CURL="curl -sSf"
FLANNEL_CNI_ROOT=$(git rev-parse --show-toplevel)
IMAGE_NAME=uhub.ucloud.cn/pingcap/flannel-cni
VERSION=v0.3.0
CNI_VERSION="v0.6.0"

mkdir -p dist
$CURL -L --retry 5 https://github.com/containernetworking/cni/releases/download/$CNI_VERSION/cni-amd64-$CNI_VERSION.tgz | tar -xz -C dist/
$CURL -L --retry 5 https://github.com/containernetworking/plugins/releases/download/$CNI_VERSION/cni-plugins-amd64-$CNI_VERSION.tgz | tar -xz -C dist/

docker build --no-cache -t $IMAGE_NAME:$VERSION .
docker push $IMAGE_NAME:$VERSION

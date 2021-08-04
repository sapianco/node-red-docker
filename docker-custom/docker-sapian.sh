#!/bin/bash
export NODE_RED_VERSION=$(grep -oE "\"node-red\": \"(\w*.\w*.\w*.\w*.\w*.)" package.json | cut -d\" -f4)

echo "#########################################################################"
echo "node-red version: ${NODE_RED_VERSION}"
echo "#########################################################################"

docker build --rm --no-cache \
    --build-arg ARCH=amd64 \
    --build-arg NODE_VERSION=16 \
    --build-arg NODE_RED_VERSION=${NODE_RED_VERSION} \
    --build-arg OS=alpine \
    --build-arg BUILD_DATE="$(date +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg TAG_SUFFIX=default \
    --build-arg VCS_REF=$(git rev-parse --short HEAD) \
    --build-arg VERSION=${NODE_RED_VERSION}-sapian-r1 \
    --file Dockerfile.sapian \
    --tag us.gcr.io/ccoe-246623/sapian/node-red:${NODE_RED_VERSION}-sapian-r1 .

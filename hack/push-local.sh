#!/usr/bin/env bash

#
# .-'_.---._'-.
# ||####|(__)||   Protect your secrets, protect your business.
#   \\()|##//       Secure your sensitive data with Aegis.
#    \\ |#//                    <aegis.ist>
#     .\_/.
#

PACKAGE="$1"
VERSION="$2"
REPO_LOCAL="$3"

# shellcheck disable=SC2046
eval $(minikube -p minikube docker-env)

docker build . -t ${PACKAGE}:${VERSION}
docker tag ${PACKAGE}:${VERSION} ${REPO_LOCAL}:${VERSION}
docker push ${REPO_LOCAL}:${VERSION}

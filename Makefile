#
# .-'_.---._'-.
# ||####|(__)||   Protect your secrets, protect your business.
#   \\()|##//       Secure your sensitive data with Aegis.
#    \\ |#//                  <aegis.z2h.dev>
#     .\_/.
#

VERSION=0.9.35
PACKAGE=aegis-sentinel
REPO=z2hdev/aegis-sentinel

all: build bundle push deploy

build-and-push: build bundle push

.PHONY: build
build:
	go build -o ${PACKAGE} ./cmd/main.go

docker-build:
	docker build . -t ${PACKAGE}:${VERSION}

bundle:
	go mod vendor
	docker build . -t ${PACKAGE}:${VERSION}

push:
	docker build . -t ${PACKAGE}:${VERSION}
	docker tag ${PACKAGE}:${VERSION} ${REPO}:${VERSION}
	docker push ${REPO}:${VERSION}

deploy:
	kubectl apply -f ./k8s/Namespace.yaml
	kubectl apply -f ./k8s/ServiceAccount.yaml
	kubectl apply -f ./k8s/Identity.yaml
	kubectl apply -f ./k8s/Deployment.yaml

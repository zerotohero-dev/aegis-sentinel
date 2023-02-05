#
# .-'_.---._'-.
# ||####|(__)||   Protect your secrets, protect your business.
#   \\()|##//       Secure your sensitive data with Aegis.
#    \\ |#//                  <aegis.z2h.dev>
#     .\_/.
#

VERSION=0.12.0
PACKAGE=aegis-sentinel
REPO=z2hdev/aegis-sentinel
REPO_LOCAL="localhost:5000/aegis-sentinel"

all: build bundle push deploy

all-local: build bundle push-local deploy-local

build-and-push: build bundle push

.PHONY: build
build:
	go mod vendor
	go build -o ${PACKAGE} ./cmd/get.go .cmd/post.go ./cmd/main.go

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

push-local:
	docker build . -t ${PACKAGE}:${VERSION}
	docker tag ${PACKAGE}:${VERSION} ${REPO_LOCAL}:${VERSION}
	docker push ${REPO_LOCAL}:${VERSION}

deploy-local:
	kubectl apply -f ./k8s/Namespace.yaml
	kubectl apply -f ./k8s/ServiceAccount.yaml
	kubectl apply -k ./k8s/
	kubectl apply -f ./k8s/Deployment.yaml

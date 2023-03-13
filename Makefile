#
# .-'_.---._'-.
# ||####|(__)||   Protect your secrets, protect your business.
#   \\()|##//       Secure your sensitive data with Aegis.
#    \\ |#//                    <aegis.ist>
#     .\_/.
#

VERSION=0.13.5
PACKAGE=aegis-sentinel
REPO=z2hdev/aegis-sentinel
REPO_LOCAL="localhost:5000/aegis-sentinel"

all: build bundle push deploy

all-local: build bundle push-local deploy-local

build-and-push: build bundle push

.PHONY: build
build:
	./hack/build.sh $(PACKAGE)

docker-build:
	./hack/docker-build.sh $(PACKAGE) $(VERSION)

bundle:
	./hack/bundle.sh $(PACKAGE) $(VERSION)

push:
	./hack/push.sh $(PACKAGE) $(VERSION) $(REPO)

deploy:
	./hack/deploy.sh

push-local:
	./hack/push-local.sh $(PACKAGE) $(VERSION) $(REPO_LOCAL)

deploy-local:
	./hack/deploy-local.sh

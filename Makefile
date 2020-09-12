SHELL := /bin/bash

DOCKER_REGISTRY := brenocosta0901/spark-py

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo "Missing '$*' variable"; \
		exit 1; \
	fi

build: guard-SPARK_VERSION
	docker build --build-arg SPARK_VERSION=$(SPARK_VERSION) -t $(DOCKER_REGISTRY):$(SPARK_VERSION) .

push: build
	docker push $(DOCKER_REGISTRY):$(SPARK_VERSION)


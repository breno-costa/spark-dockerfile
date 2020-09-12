# Spark Dockerfile 

Spark distributions available in [spark website](https://spark.apache.org/downloads.html) usually have a [docker-image-tool.sh](https://github.com/apache/spark/blob/master/bin/docker-image-tool.sh) to generate spark docker images. This repository is heavily based on [dockerfiles](https://github.com/apache/spark/blob/master/resource-managers/kubernetes/docker/src/main/dockerfiles/spark/Dockerfile) used by that cli, and aims to ease to build and publish spark images ready to run on kubernetes cluster.

## How to use

You can build spark image using command below.

```bash
make build SPARK_VERSION=3.0.0
```

or you could publish directly to the registry.

```bash
make publish SPARK_VERSION=3.0.0
```

PS: you need to change `DOCKER_REGISTRY` in Makefile.


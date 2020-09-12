FROM openjdk:8-jre-slim

ARG SPARK_VERSION

RUN set -ex && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules krb5-user libnss3 && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd

RUN apt install -y curl python3 python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    rm -rf /var/cache/apt/*

RUN curl https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz | \
    tar -xz -C /opt && \
    ln -s /opt/spark-${SPARK_VERSION}-bin-hadoop2.7 /opt/spark && \
    ln -s /opt/spark/kubernetes/dockerfiles/spark/entrypoint.sh /opt/entrypoint.sh && \
    mv /opt/spark/python/lib/py4j*.zip /opt/spark/python/lib/py4j.zip && \
    rm -rf /opt/spark/yarn /opt/spark/R

ENV SPARK_HOME /opt/spark
ENV PATH $PATH:$SPARK_HOME/bin

ENV PYSPARK_PYTHON=python
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j.zip:$PYTHONPATH

WORKDIR ${SPARK_HOME}/work-dir
RUN chmod g+w ${SPARK_HOME}/work-dir

ENTRYPOINT [ "/opt/entrypoint.sh" ]

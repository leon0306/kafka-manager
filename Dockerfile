FROM centos:7

MAINTAINER Boxuan <chenboxuan3@xdf.com>

RUN yum update -y && \
    yum install -y java-1.8.0-openjdk-headless && \
    yum clean all

ENV JAVA_HOME=/usr/java/default/ \
    ZK_HOSTS=localhost:2181 \
    KM_VERSION=1.3.3.21 \
    KM_CONFIGFILE="conf/application.conf"

ADD kafka-manager-${KM_VERSION}.zip /root

RUN yum install -y git unzip which && \
    mkdir -p /tmp && \
    unzip  -d / /root/kafka-manager-${KM_VERSION}.zip && \
    rm -rf /root/.sbt /root/.ivy2 && \
    rm -rf /kafka-manager-${KM_VERSION}/conf/application.conf /kafka-manager-${KM_VERSION}/conf/consumer.properties && \
    yum autoremove -y git unzip which && \
    yum clean all

COPY consumer.properties /kafka-manager-${KM_VERSION}/conf/consumer.properties
COPY application.conf /kafka-manager-${KM_VERSION}/conf/application.conf
COPY kafka_jaas.conf /kafka-manager-${KM_VERSION}/conf/kafka_jaas.conf
COPY start-kafka-manager.sh /kafka-manager-${KM_VERSION}/start-kafka-manager.sh

RUN chmod +x /kafka-manager-${KM_VERSION}/start-kafka-manager.sh

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000
ENTRYPOINT ["./start-kafka-manager.sh"]

# kafka-manager

包含了kafka-manager-1.3.3.21版本的docker image.
最新支持到kafka-1.1.0版本的数据采集以及WEB展示.

+ 运行命令
```
docker run --name kafka-manager -d  -p 9000:9000 -e ZK_HOSTS="zkhost:2181" -e APPLICATION_SECRET=letmein kafka-manager-sasl:1.3.3.21
```

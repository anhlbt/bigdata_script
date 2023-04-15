# FROM flink:1.14.6
# RUN wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-elasticsearch7_2.12/1.14.6/flink-sql-connector-elasticsearch7_2.12-1.14.6.jar -O /opt/flink/lib/flink-sql-connector-elasticsearch7_2.12-1.14.6.jar \
#   && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-oracle-cdc/2.2.1/flink-sql-connector-oracle-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-oracle-cdc-2.2.1.jar \
#   && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-mysql-cdc/2.2.1/flink-sql-connector-mysql-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-mysql-cdc-2.2.1.jar \
#   && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-postgres-cdc/2.2.1/flink-sql-connector-postgres-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-postgres-cdc-2.2.1.jar \
#   && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-mongodb-cdc/2.2.1/flink-sql-connector-mongodb-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-mongodb-cdc-2.2.1.jar \
#   && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-sqlserver-cdc/2.2.1/flink-sql-connector-sqlserver-cdc-2.2.1.jar -O /opt/flink/lib/flink-sql-connector-sqlserver-cdc-2.2.1.jar \
#   && wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka_2.12/1.14.6/flink-sql-connector-kafka_2.12-1.14.6.jar -O /opt/flink/lib/flink-sql-connector-kafka_2.12-1.14.6.jar \
#   && wget https://repo1.maven.org/maven2/com/alibaba/ververica/flink-format-changelog-json/1.4.0/flink-format-changelog-json-1.4.0.jar -O flink-format-changelog-json-1.4.0.jar
#   # && wget https://repo1.maven.org/maven2/com/ververica/flink-format-changelog-json/2.0.2/flink-format-changelog-json-2.0.2.jar -O /opt/flink/lib/flink-format-changelog-json-2.0.2.jar


FROM flink:1.13.2-scala_2.11

# Download connector libraries
RUN wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-elasticsearch7_2.12/1.13.2/flink-sql-connector-elasticsearch7_2.12-1.13.2.jar; \
    wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka_2.11/1.13.2/flink-sql-connector-kafka_2.11-1.13.2.jar; \
    wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-connector-jdbc_2.11/1.13.2/flink-connector-jdbc_2.11-1.13.2.jar; \
    wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-mysql-cdc/2.0.2/flink-sql-connector-mysql-cdc-2.0.2.jar; \
    wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-postgres-cdc/2.0.2/flink-sql-connector-postgres-cdc-2.0.2.jar; \
    wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/ververica/flink-connector-debezium/2.0.2/flink-connector-debezium-2.0.2.jar; \
    wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/ververica/flink-connector-mysql-cdc/2.0.2/flink-connector-mysql-cdc-2.0.2.jar; \
    wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/ververica/flink-connector-postgres-cdc/2.0.2/flink-connector-postgres-cdc-2.0.2.jar; \
    wget -P /opt/flink/lib/ https://repo1.maven.org/maven2/com/ververica/flink-format-changelog-json/2.0.2/flink-format-changelog-json-2.0.2.jar; \
    wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar; \
    wget -P /opt/flink/lib/  https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/2.7.3/hadoop-mapreduce-client-core-2.7.3.jar; \
    wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.19/mysql-connector-java-8.0.19.jar;

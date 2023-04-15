## Flink SQL CLient uses HiveCatelog DEMO

### Quick Start
1. Use `docker-compose up -d` in the directory to start a hdfs, hive, kafka local test cluster
2. Download flink-1.14.2 version, decompress, `./bin/start-cluster.sh` starts a flink cluster
3. According to the flink-jar-dep.jpg in the directory, download the corresponding jar package to the flink lib directory
4. Modify the hive-conf-dir attribute in the sql-init.sql file in the directory, which needs to point to the absolute path of the flink-hive-conf directory
5. You can send to Kafka's test topic writes data, and the data style is as follows: `tom,1`
6. Running `./bin/sql-client.sh -i ${path}/sql-init.sql` of link-1.14.2 will automatically initialize the table environment
7. Run `select * from mykafka;` in the sql client to get the data just written to kafka
8. You can connect to hive through `docker exec -it hive_hive-server_1 /opt/hive/bin/beeline -u jdbc:hive2://hive-server:10000 hive hive`, and through `show create table mykafka;` you can View the metadata structure of flink stored in hive

### Experimental results
1. After the metadata in hive is changed, flink cannot automatically obtain it, and the application still needs to be restarted
2. Flink sql currently cannot modify the table structure, it can only be deleted and rebuilt (this action will not affect other applications that use the old structure)
3. Whether it is missing fields or adding fields, format will throw an exception and cause the program to hang
4. Considering the third point, you can add parameters like `'csv.ignore-parse-errors' = 'true'`, so that when adding new fields, the missing fields will be filled with null. But there will be data with new fields, and the old application will be automatically discarded
5. Flink supports two types of tables on hive, general tables (only store table structure metadata, hive can only view table creation statements, others cannot be operated), hive compatible tables (like hive tables, hive can write data or action table structure)

### Summarize
At present, if you want to use hive metastore to manage flink metadata in a unified way, there is no way to do it out of the box
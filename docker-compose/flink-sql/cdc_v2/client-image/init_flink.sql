--Flink SQL

-- 设置 checkpoint 间隔为 3 秒    


SET execution.checkpointing.interval = 3s;

CREATE TABLE products (
   id INT,
   name STRING,
   description STRING,
   PRIMARY KEY (id) NOT ENFORCED
 ) WITH (
   'connector' = 'mysql-cdc',
   'hostname' = 'localhost',
   'port' = '3306',
   'username' = 'root',
   'password' = '123456',
   'database-name' = 'mydb',
   'table-name' = 'products'
 );

CREATE TABLE orders (
   order_id INT,
   order_date TIMESTAMP(0),
   customer_name STRING,
   price DECIMAL(10, 5),
   product_id INT,
   order_status BOOLEAN,
   PRIMARY KEY (order_id) NOT ENFORCED
 ) WITH (
   'connector' = 'mysql-cdc',
   'hostname' = 'localhost',
   'port' = '3306',
   'username' = 'root',
   'password' = '123456',
   'database-name' = 'mydb',
   'table-name' = 'orders'
 );

CREATE TABLE shipments (
   shipment_id INT,
   order_id INT,
   origin STRING,
   destination STRING,
   is_arrived BOOLEAN,
   PRIMARY KEY (shipment_id) NOT ENFORCED
 ) WITH (
   'connector' = 'postgres-cdc',
   'hostname' = 'localhost',
   'port' = '5432',
   'username' = 'postgres',
   'password' = 'postgres',
   'database-name' = 'postgres',
   'schema-name' = 'public',
   'table-name' = 'shipments'
 );

CREATE TABLE enriched_orders (
   order_id INT,
   order_date TIMESTAMP(0),
   customer_name STRING,
   price DECIMAL(10, 5),
   product_id INT,
   order_status BOOLEAN,
   product_name STRING,
   product_description STRING,
   shipment_id INT,
   origin STRING,
   destination STRING,
   is_arrived BOOLEAN,
   PRIMARY KEY (order_id) NOT ENFORCED
 ) WITH (
     'connector' = 'elasticsearch-7',
     'hosts' = 'http://localhost:9200',
     'index' = 'enriched_orders'
 );

INSERT INTO enriched_orders
SELECT 
  o.*, 
  p.name as product_name, 
  p.description as product_description, 
  s.shipment_id, 
  s.origin, 
  s.destination, 
  s.is_arrived
FROM orders AS o
LEFT JOIN products AS p ON o.product_id = p.id
LEFT JOIN shipments AS s ON o.order_id = s.order_id;



--Flink SQL
CREATE TABLE kafka_gmv (
   day_str STRING,
   gmv DECIMAL(10, 5)
) WITH (
    'connector' = 'kafka',
    'topic' = 'kafka_gmv',
    'scan.startup.mode' = 'earliest-offset',
    'properties.bootstrap.servers' = 'localhost:9092',
    'format' = 'changelog-json'
);

INSERT INTO kafka_gmv
SELECT DATE_FORMAT(order_date, 'yyyy-MM-dd') as day_str, SUM(price) as gmv
FROM orders
WHERE order_status = true
GROUP BY DATE_FORMAT(order_date, 'yyyy-MM-dd');

-- Read the changelog data of Kafka and observe the result after materialize
SELECT * FROM kafka_gmv;

docker-compose exec kafka bash -c 'kafka-console-consumer.sh --topic kafka_gmv --bootstrap-server kafka:9094 --from-beginning'


-- MySQL
UPDATE orders SET order_status = true WHERE order_id = 10001;
UPDATE orders SET order_status = true WHERE order_id = 10002;
UPDATE orders SET order_status = true WHERE order_id = 10003;

-- MySQL
INSERT INTO orders
VALUES (default, '2020-07-30 17:33:00', 'Timo', 50.00, 104, true);

-- MySQL
UPDATE orders SET price = 40.00 WHERE order_id = 10005;

-- MySQL
DELETE FROM orders WHERE order_id = 10005;

--The resulting data format is as follows
{"data":{"day_str":"2020-07-30","gmv":50.5},"op":"+I"}
{"data":{"day_str":"2020-07-30","gmv":50.5},"op":"-U"}  Represents the data before the update
{"data":{"day_str":"2020-07-30","gmv":65.5},"op":"+U"}  represents the updated data
{"data":{"day_str":"2020-07-30","gmv":65.5},"op":"-U"}
{"data":{"day_str":"2020-07-30","gmv":90.75},"op":"+U"}
{"data":{"day_str":"2020-07-30","gmv":90.75},"op":"-U"}
{"data":{"day_str":"2020-07-30","gmv":140.75},"op":"+U"}
{"data":{"day_str":"2020-07-30","gmv":140.75},"op":"-U"}
{"data":{"day_str":"2020-07-30","gmv":90.75},"op":"+U"}
{"data":{"day_str":"2020-07-30","gmv":90.75},"op":"-U"}
{"data":{"day_str":"2020-07-30","gmv":130.75},"op":"+U"}
{"data":{"day_str":"2020-07-30","gmv":130.75},"op":"-U"}
{"data":{"day_str":"2020-07-30","gmv":90.75},"op":"+U"}
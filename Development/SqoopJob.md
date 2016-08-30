
## Download
[root@bmaster1 ~]# wget http://stat-computing.org/dataexpo/2009/1999.csv.bz2

## unzip
[root@bmaster1 ~]# bzip2 -d 1999.csv.bz2


## Create table

mysql> CREATE DATABASE flight_db;
Query OK, 1 row affected (0.04 sec)

mysql> create table ontime (   Year int,   Month int,   DayofMonth int,   DayOfWeek int,   DepTime  int,   CRSDepTime int,   ArrTime int,   CRSArrTime int,   UniqueCarrier varchar(5),   FlightNum int,   TailNum varchar(8),   ActualElapsedTime int,   CRSElapsedTime int,   AirTime int,   ArrDelay int,   DepDelay int,   Origin varchar(3),   Dest varchar(3),   Distance int,   TaxiIn int,   TaxiOut int,   Cancelled int,   CancellationCode varchar(1),   Diverted varchar(1),   CarrierDelay int,   WeatherDelay int,   NASDelay int,   SecurityDelay int,   LateAircraftDelay int );

__You can also use above schema to define hive table__
__If you want to import above table directly into hive :__
```sh
[hdfs@bmaster1 bhavin]$ sqoop create-hive-table --connect jdbc:mysql://bmaster1.cloudwick.com/flight_db --table ontime --username sqoop --password sqoop --driver com.mysql.jdbc.Driver
```

## Load data into MySQL

mysql> use flight_db;
Database changed

mysql> LOAD DATA LOCAL INFILE '~/1999.csv' INTO TABLE ontime FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 LINES;
Query OK, 5527884 rows affected, 65535 warnings (1 min 13.11 sec)
Records: 5527884  Deleted: 0  Skipped: 0  Warnings: 5527884

## Checking databases and tables using sqoop

[root@bmaster1 ~]# sqoop list-databases --connect jdbc:mysql://localhost --username root -P
Warning: /usr/hdp/2.4.2.0-258/hbase does not exist! HBase imports will fail.
Please set $HBASE_HOME to the root of your HBase installation.
Warning: /usr/hdp/2.4.2.0-258/accumulo does not exist! Accumulo imports will fail.
Please set $ACCUMULO_HOME to the root of your Accumulo installation.
16/07/07 11:47:08 INFO sqoop.Sqoop: Running Sqoop version: 1.4.6.2.4.2.0-258
Enter password:
16/07/07 11:47:10 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
information_schema
ambari
flight_db
hive
mysql
oozie
ranger
ranger_audit
test

[root@bmaster1 ~]# sqoop list-tables --connect jdbc:mysql://localhost/flight_db --username root -P
Warning: /usr/hdp/2.4.2.0-258/hbase does not exist! HBase imports will fail.
Please set $HBASE_HOME to the root of your HBase installation.
Warning: /usr/hdp/2.4.2.0-258/accumulo does not exist! Accumulo imports will fail.
Please set $ACCUMULO_HOME to the root of your Accumulo installation.
16/07/07 11:47:35 INFO sqoop.Sqoop: Running Sqoop version: 1.4.6.2.4.2.0-258
Enter password:
16/07/07 11:47:36 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
ontime


## Create user sqoop

mysql> CREATE USER 'sqoop'@'%' IDENTIFIED BY 'sqoop';
Query OK, 0 rows affected (0.00 sec)

mysql> GRANT SELECT ON flight_db.* TO 'sqoop'@'%';
Query OK, 0 rows affected (0.00 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.00 sec)


## Run Sqoop job 

[root@bmaster1 ~] sqoop import --connect jdbc:mysql://bmaster1.cloudwick.com:3306/flight_db \
--username sqoop \
--password sqoop \
--table ontime \
--split-by Month \
--m 12 \
--driver com.mysql.jdbc.Driver


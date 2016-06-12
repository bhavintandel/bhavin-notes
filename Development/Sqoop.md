# Sqoop

Apache Sqoop is an open source tool that allows users to extract data from a structured data store into Hadoop for further processing. It’s even possible to use Sqoop to move data from a database into HBase.

Sqoop 2 has a server component that runs jobs, as well as a range of clients: a command-line interface (CLI), a web UI, a REST API, and a Java API. Sqoop 2 also will be able to use alternative execution engines, such as Spark. Note that Sqoop 2’s CLI is not compatible with Sqoop 1’s CLI.

### Avilable commands
  command | Description
  --------|---------------
  codegen |            Generate code to interact with database records
  create-hive-table |  Import a table definition into Hive
  eval |              Evaluate a SQL statement and display the results
  export |             Export an HDFS directory to a database table
  help |              List available commands
  import |             Import a table from a database to HDFS
  import-all-tables |  Import tables from a database to HDFS
  import-mainframe |  Import datasets from a mainframe server to HDFS
  job |               Work with saved jobs
  list-databases |     List available databases on a server
  list-tables |       List available tables in a database
  merge |             Merge results of incremental imports
  metastore |         Run a standalone Sqoop metastore
  version |           Display version information


## Sqoop Connector
Sqoop ships with connectors for working with a range of popular databases, including MySQL, PostgreSQL, Oracle, SQL Server, DB2, and Netezza. There is also a generic JDBC connector for connecting to any database that supports Java’s JDBC protocol.

## Setup Sqoop Environment

  1. we need to export Sqoop bin to PATH variable.
```sh
  export SQOOP_HOME=/usr/hdp/2.4.2.0-258/sqoop
  export PATH=$PATH:$SQOOP_HOME/bin
```

  2. we need to download JDBC jar files 
```sh
   wget http://ftp.ntu.edu.tw/MySQL/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz
   tar -zxf mysql-connector-java-5.1.36.tar.gz
   cd mysql-connector-java-5.1.36/
   mv mysql-connector-java-5.1.36-bin.jar $SQOOP_HOME/lib
```

[Here](http://www.tutorialspoint.com/sqoop/sqoop_installation.htm) is the tutorialspoint for sqoop installation.


## Sample Import

_Create Database in MySQL_
```sql
mysql> CREATE DATABASE hadoopGuide;
Query OK, 1 row affected (0.00 sec)

mysql> GRANT ALL PRIVILEGES ON hadoopGuide.* TO ''@'localhost';
Query OK, 0 rows affected (0.00 sec)

mysql> quit;
Bye
```

_Create Table_
```sql
[root@bmaster2 ~]# mysql hadoopGuide
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.1.73 Source distribution

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE TABLE widegets(id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    -> widget_name VARCHAR(64) NOT NULL,
    -> price DECIMAL(10,2),
    -> design_date DATE,
    -> version INT,
    -> design_comment VARCHAR(100));
Query OK, 0 rows affected (0.01 sec)

mysql> INSERT INTO widegets VALUES(NULL, 'sprocket', 0.25, '2010-02-10',
    -> 1, 'Connects to gizmos');
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO widegets VALUES(NULL, 'gizmo', 4.00, '2000-11-10', 4, NULL);                                                                                                                 Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO widegets VALUES(NULL, 'gadget', 9.90, '1995-04-10', 13, 'Our                                                                                                                 flasship');
Query OK, 1 row affected (0.00 sec)

mysql> quit;
Bye
```
_Import the previous table_
```sh
 sudo -u hdfs sqoop import --connect jdbc:mysql://localhost/hadoopGuide --table widegets -m 1
```

```sh
sudo -u hdfs hdfs dfs -cat widegets/part-m-00000
1,sprocket,0.25,2010-02-10,1,Connects to gizmos
2,gizmo,4.00,2000-11-10,4,null
3,gadget,9.90,1995-04-10,13,Our flasship
```
By default it sqoop runs 4 map tasks and finally different file are written under same directory. But here we have ask it to use 1 map.

In production we dont use localhost beacuse if the ap task is initiated to other node then it will not be able to find the database. So following privileges need to be given.

```
GRANT ALL PRIVILEGES ON hadoopGuide.* TO ''@'bmaster2.cloudwick.com';

flush privileges;
``` 

And Use
```
sudo -u hdfs sqoop import --connect jdbc:mysql://bmaster2.cloudwick.com/hadoopGuide --table widegets -m 1
```

By default, Sqoop generate comma-delimited text files for our imported data. The command-line arguments that specify delimiter characters, file formats, compression.
But text file doest support VARBINARY and cant distinguish between null and string "null"
To handle these, Sqoop supports SequenceFiles, Avro and Parquet. Another disadvantage of SequenceFiles is that they are Java specific, whereas Avro and Parquet files can be processed by a wide range of languages.

It also generate java code, you can see it by `ls widegets.java` It is located into tmp folder i.e,
`/tmp/sqoop-hdfs/compile/52e307e4d049884dca48cb7e0b825b2c/`

Also __codegen__ is used to generate java code for ex.
`sqoop codegen --connect jdbc:mysql://localhost/hadoopguide --table widgets --class-name Widget`

__You can use _--driver_ argument which allows connector to be specified at run time.__
![Image of sqoop process](http://1.bp.blogspot.com/-uVCFmXacjhY/Uo0LsNGGXMI/AAAAAAAAAP4/jwTzyKrhn8k/s1600/1.png)

The DataDrivenDBInputFormat provided with Hadoop partitions a query’s results over several map tasks.

Sqoop's _DataDrivenDBInputFormat_ uses _splitting column_ that is generally Primary key to drivide the task equally among the mappers. This can be achieved via __--split-by__ argument. If job run as single map (-m 1) then split is not performed.

__--where__ argument can be used to import subset of the table and this is applied before splitting.

Sqoop provides _incremental imports_ which can help to synchronize the data from DB. __--check-column && --last-value__ can be used to import those row that is greater than this specific value. Another is time-based incremental imports (__--incremental lastmodified__)

__Direct-Mode__ imports are special tools that are DB specific and most of the time faster than JDBC like _mysqldump_ provided by MYSQL. Can be specified by __--direct__ argument. But metadata is always queried through JDBC.

Hive is Sqoop is very efficient combination, so it is possible for sqoop to generate hive tables.
```sh
sudo -u hdfs sqoop create-hive-table --connect jdbc:mysql://bmaster2.cloudwick.com/hadoopGuide --table widegets --fields-terminated-by ','
```
If we know that we have to import data directly into hive then we can use one direct command.
`sqoop import --connect jdbc:mysql://localhost/hadoopGuide -table widegets -m 1 --hive-import`

In many case, companies have a big fields present in the DB, like in our widgets table we might have schematic column holding actual schema of product. This type of column is stored in _BLOB or CLOB_. Sqoop will store such field as _LobFile_, if larger than threshold 16MB which can be tweeked by `sqoop.inline.lob.length.max` Our import might looks like
2,gizmo,4.00,2009-11-30,4,null,externalLob(lf,lobfile0,100,5011714)
Widgets.get_schematic() returns object of BlobRef of this column. And BlobRef.getDataStream() method actuallu opens th LobFile and returns an InputStream.


## Export

We are going to export the zip_profits table from Hive. We need to create a table in MySQL that has target columns in the same order, with the appropriate SQL types

```sql
mysql hadoopGuide
mysql> CREATE TABLE sales_by_zip (volume DECIMAL(8,2), zip INTEGER);
```

To export 

```sh
sqoop export --connect jdbc:mysql://localhost/hadoopguide -m 1 \
--table sales_by_zip --export-dir /user/hive/warehouse/zip_profits \
--input-fields-terminated-by '\0001'
```
_`\0001`(Ctrl-A)__ is default delimiter used by hive.

Another example is (mysql hadoopGuide has widegets_from_HDFS table) 
```sh
 sudo -u hdfs sqoop export --connect jdbc:mysql://bmaster2.cloudwick.com/hadoopGuide -m 1 \
 --table widegets_from_HDFS \
 --export-dir /user/hdfs/widegets \
 --input-fields-terminated-by ','
```

To avoid distortion we can use --staging-table argument which first copies data as staged and the copy to final table when whole export is completed.

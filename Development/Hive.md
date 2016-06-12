## Overview 

  * Data warehousing application in hadoop.
  * It uses SQL-like language which generate MapReduce jobs.
  * Developed by Facebook.

## Data Model

  * Tables (int, float, struct, list, arrays:map (JSON-like))
  * Partitions (by dates)
  * Buckets (join optimization)

## How Hive loads
  
  * Default location is `/user/hive/warehouse/<table_name>` or `/apps/hive/warehouse/<table_name>`, it can be find in hive-site.xml.
  * It stores metadata in RDBMS such as MYSQL.
  * ![Hive_architecture](http://img.blog.csdn.net/20130730112101750)
  * Hive is better than RDBMS because of its scalability on data (Petabytes).

## Using Hive
  * Use `hive` command to start command line interface.
  * `quit` to exit.
  * To execute HiveOL written we use `hive -f myquery.hql`.
  * To execute hive query directly from command line `hive -e 'SELECT * FROM users'`.
  * use -S to suppress the informationl messages.
  * `set -v` can be used to check current values.
  * Use ! to use system command. `hive> ! date;`
  * Use _dfs_ for HDFS command `hive> dfs -mkdir /reports/sales/2013;`

## Configuring Hive Metastore

  1. Embedded Mode (default)
    Uses __derby__ database. Both database & metastore service run embedded in main HiveServer process.
  2. Local Mode
    Metastore service runs with main HiveServer process and Metastore database run as seperate process or on separate host.
  3. Remote Mode (Recommended)
    Metastore service runs in its own JVM, other processes communicates via Thrift network API. Metastore service communicate with database over JDBC. 


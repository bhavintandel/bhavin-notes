# Hive Intro

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


# Hive (Relational Data Analytics)

## Hive Tables

  * Each table maps to single directory which is stored as text (by default) and sub-directories are not allowed.
  * It uses metastore t give context to the data.
  * It supports multiple database.

## Exploring commands

  1. SHOW DATABASES;
  2. USE <database_name>;
  3. SHOW TABLES;
  4. SHOW TABLES IN <database_name>;
  5. DESCRIBE <database_name>;
  6. DESCRIBE FORMATTED <database_name>;

## HiveQL Basics

  * It is case-insensitive and terminated by semicolon(;).
  * Comment begins with -- (double hyphen) with no multi-line comments.

```sh
$ cat myScript.hql

SELECT id, name, addr
  FROM students
  WHERE marks>70; -- distinction
```

  * LIMIT, sets maximum number of rows returned. -- _Caution:_ no guarantee regarding which 10 results are returned.
    * Use ORDER BY for top-N queries.

    ```sql
    hive> SELECT id, fname,lname FROM students
          ORDER BY id DESC LIMIT 10;
    ```
  * Using WHERE & AND

  ```sql
  hive> SELECT * FROM customers WHERE fname LIKE
  'DI%' AND (city='Seattle' OR city='Portland');
  ```

  * Table Aliases can be used to simplify the work, we cannot use __AS__ to specify table aliases 
  
  ```sql
  hive> SELECT o.order_date, c.fname, f.addr
        FROM customers c JOIN orders o
	ON c.cust_id = o.cust_id
	WHERE c.zipcode='94306';
  ```

  * UNION ALL can be used to print concatenated output but each query must match

  ```sql
  hive> SELECT id, name, lname
         FROM employees
	 WHERE state='CA' AND salary > 75000
	UNION ALL
	SELECT id, name, lname
	 FROM employees
	 WHERE state='MA' AND salary > 85000
  ```

  * It supports Subqueries only in FROM clause:

  ```sql
  hive> SELECT prod_id, brand, name
        FROM (SELECT * 
	      FROM products
	      WHERE price > 500
	      ORDER BY price DESC
	      LIMIT 10) high_profits
	WHERE price > 1000
	ORDER BY brand, name;
  ```


## Hive Datatypes
  
  * Integer
    1. TINYINT
    2. SMALLINT
    3. INT
    4. BIGINT
  
  * Decimal
    1. FLOAT
    2. DECIMAL

  * STRING
  * BOOLEAN
  * TIMESTAMP
  * BINARY
  * COMPLEX
    1. ARRAY
    2. MAP
    3. STRUCT

## Joins in Hive
  1. Inner Joins
  2. Outer Joins (left, right and full)
  3. Cross Joins
  4. Left semi joins
 
  * Only equality conditions are allowed : customers.cus_id = orders.cus_id
  * For best performance, _list larger table at end_

  ```sql
  hive> SELECT c.cus_id, name, total
        FROM customers c
	JOIN orders o 
	ON (c.cus_id = o.cus_id); 
  ```
  * Hive doesn't support IN/EXISTS subqueries.


## Hive BuiltIn Functions

  * Function names are not case sensitive. 
  ```sql
  hive> SELECT CONCAT(fname, ' ', lname) AS fullname
        FROM customer;
  ```
  * To see type, `DESCRIBE FUNCTION <func_name>;`





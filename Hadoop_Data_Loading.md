## Loading data into Hadoop

### Schema on Read vs Schema on Write

  * _Schema on Write_: We have to define columns and data format while loading the data. Reading is pretty fast and all user will observe same database.
  ![Image of Schema on write](https://blogs.oracle.com/datawarehousing/resource/BigDataFilanovskiy/1_sr_sw2.png)

  * _Schema on Read_: We dont apply any transformation while loading and file are just loaded skipping ETL step. Same data can be read in different manner.
  ![Image of Schema on read](https://blogs.oracle.com/datawarehousing/resource/BigDataFilanovskiy/2_sr_sw.png)

  * That means __Data loading into Hadoop is not equal to ETL(data doesn't transform)__

### General Classification

  * Basically there are two types of data loading and data source: __Stream__ and __Batch__.
  ![Stream & Batch loading](https://blogs.oracle.com/datawarehousing/resource/BigDataFilanovskiy/3_classification.png)

### Hadoop Client

  * `sudo -u hdfs hdfs dfs -put /tmp/ratings.csv /movielens`
  * We should make sure that hdfs has read permission on local system. [This](http://stackoverflow.com/questions/18484939/hadoop-fs-put-command) stack overflow explains this concept.
  
  #### Loading data into hive
  * Login into hive: `sudo -u hdfs hive`
  * Create database and table. [Here](http://www.tech-ab.net/bigdata/hadoop/hortonworks-data-platform-centos-7-part-8-import-data-hdfs-create-hive-table-load-hive-table/) is great link which explains in short. Also [This](https://www.youtube.com/watch?v=tR8_ItrB1Tc) video is very explanatory 


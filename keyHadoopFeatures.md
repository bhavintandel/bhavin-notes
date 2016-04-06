## Key features of Hadoop

* HDFS
  1. HortonWorks scale upto 200 PB and nearly 4500 servers per one cluster.
  2. NameNode doesn't request DataNode, it replies to _heartbeats_.
  3. **OZONE* new initiatives lets you store objects like fb image on HDFS.



## Apache Hadoop

* Apache Hadoop is an open source framework for distributed storage and
processing of large dataset on comodity hardware.

* Apache Hadoop framework consists of:
  1. __Hadoop Common__ – contains libraries and utilities needed by other Hadoop modules.
  2. __Hadoop Distributed File System (HDFS)__ – a distributed file-system that stores data on commodity machines, providing very high aggregate bandwidth across the cluster.
  3. __Hadoop YARN__ – a resource-management platform responsible for managing computing resources in clusters and using them for scheduling of users' applications.
  4. __Hadoop MapReduce__ – a programming model for large scale data processing.

* 5 Pillars of Hadoop

  ####1. Data Management
    * Apache Hadoop YARN
    * HDFS

  ####2. Data Access
    * Hive is widely used for quering database.
    * Pig for scripting 
    * Storm for real time processing
    * HBase for NoSQL storage 
    * Accumulo offers cell-level acsess
    * Apache Mahout– Mahout provides scalable machine learning algorithms for Hadoop.

  ####3. Data Governance and Integration
    * Falcon provides policy-based workflow for data governance.
    * Flume allows large amount of log data integration.
    * Sqoop easy movement of data in or out of hadoop. 

  ####4. Security
    *
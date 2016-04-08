
## Key features of Hadoop

* HDP
  1. HortonWorks scale upto 200 PB and nearly 4500 servers per one cluster.
  2. NameNode doesn't request DataNode, it replies to _heartbeats_.
  3. *OZONE* new initiatives lets you store objects like fb image on HDFS.



## 1. Apache Hadoop

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
    * Knox provides single point of authentication and access to hadoop services.
    * Ranger delivers comprehensive approach to security for hadoop cluster.

  ####5. Operations
    * Ambari is open source installation lifecycle management, administration and monitoring system.
    * Oozie used to schedule hadoop jobs.
    * ZooKeeper coordinating distributed processes.

* Characteristic of hadoop
  1. Volume
  2. Velocity
  3. Variety
  4. Variability (different semantics)


## Apache YARN

* Idea is to split up the functionalities of resource management and job scheduling into seperate daemons.
* Node Manager(at every node) is responsible for continers, monitoring resource usage and reporting to RM.
* Resources Manager consists of:
    1. _Scheduler_: which purely schedule the task and doesn't monitor any tasks.
    2. _Application Manager_: Accepts job-submissions, execute the Appliction Master on the container and also restart if job fails.
* No segregation of task(like one in MRv1)


## 2. HDFS

* It is scalable, fault-tolerance, distributed storage system which can span upto 4500 nodes per cluster.
* Files are splited into block of 128 MB and replicated accross multiple nodes.
* Namenode maintains Namespace tree holding the entire namespace image in RAM.
* HDFS metadata consists of:
    1. fsimage: contains complete state of the file system at a point in time.
    2. edits log that lists each file system change made after most recent fsimage.
* _Checkpointing_ is process of merging the content of most recent fsimage with all edits.


### NameNode
* It consists of:
  1. VERSION
  2. edits_start transaction ID - end transaction ID
  3. edits_inprogress__start transaction ID
  4. fsimage_end transaction ID
  5. seen_txid: if edit logs is deleted, NameNode can check this file.
  6. in_use.lock

### JournalNode
* It is used in deployment of HA, it contains edit logs file as NameNode except fsimage.

### DataNode

* It consists of:
  1. BP-randon integer-NameNde-IP address-creation time
  2. VERSION
  3. rbw/finalized: replica being written has block that is being written. While finalized contains blocks that are not yet written.
  4. lazyPersist
  5. dncp_block_verification.log: last verification time
  6. in_use.lock: held by DataNode process, used to prevent multiple DataNode from starting up & modifiying directory

### HDFS commands

* _hdfs namenode_ :  namenode startup saves new checkpoint
* _hdfs dfsadmin -safemode enter_ 
commands | description
-------- | -----------
_hdfs namenode_ | namenode startup saves new checkpoint
_hdfs dfsadmin -safemode enter_ | 
_hdfs dfsadmin -saveNamespace_ | Saves new checkpoint while NameNode process keeps running
_hdfs dfsadmin -rollEdits_ | manually rolls edits
_hdfs dfsadmin -fetchimage_ download latest fsimage from NN, useful for backup

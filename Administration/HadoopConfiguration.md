## Configuration of Hadoop

Main Categories:
  1. Cluster
  2. Daemon
  3. Job
  4. Individual operation level

First two controlled by admin and latter two by developer.
Developer can override the properties set by admin through program, but if admin marked the property as __final__ then it will ignore its value set by developer.


#### Configuring HDFS

1. fs.defaultFS (core-site.xml) : default FileSystem (where namenode runs) 
2. dfs.namenode.name.dir : Where namenode stores metadata. Administrator must specify two internal disks where namenode metadata will be replicated. 
```sh
<property>
     <name>dfs.namenode.name.dir</name>
     <value>/grid/hadoop/hdfs/nn,/grid1/hadoop/hdfs/nn</value>
     <description>Comma-separated list of paths. Use the list of directories from $DFS_NAME_DIR. For example, /grid/hadoop/hdfs/nn,/grid1/hadoop/hdfs/nn.</description>
</property>
```

#### Optimizing & Tuning

1. io.file.buffer.size (core-site.xml) : Used by hadoop to perform IO from disk or over the network. Bigger the value, more efficient data transfer but more memory consumption & latency.
2. dfs.datanode.balance.bandwidthPerSec : This parameter is used by datanode to balance the data over all the nodes. If it is high then it will monopolize the network leaving nothing for MapReduce jobs.
3. dfs.blocksize : every file has an associated block size which is determined when the file is created. default = 134217728 (128 MB)
4. dfs.datanode.du.reserved: This property allow us to reserve space for mapreduce jobs on every datanode. Default is 10GB. But it can be tweeked for bigger job.
5. dfs.namnode.handler.count: Larger number of handlers means greater capacity to handle concurrent heartbeats from datanodes as well as metadata operation from clients. Default = 50
It ideal value for larger cluster is Int(log(number of nodes) * 20)
6. dfs.datanode.failed.volumes.tolerated: Specifies number of disks that are permitted to die before failing the entire datanode. Default = 0
7. dfs.host.exclude: hosts specified in dfs.exclude file is excluded.
8. fs.trash.interval: When we delete a file from cmdLine, it is transfer to _.Trash_ directory and it stays there till the minutes specified by this property. Default = 0 or 360



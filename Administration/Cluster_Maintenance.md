# Cluster Maintenance

Tasks: 
  1. Expanding the cluster
  2. Dealing with failures or errant jobs
  3. Managing logs
  4. Upgrading softwares

When we stop **datanode**, its blocks are replicated.

When **task tracker** is stopped the child tasks are killed and retried on another task tracker.

To start or stop a service 
  `sudo /etc/init.d/_script_ operation`
  script = service
  operation = start, stop & restart

To confirm if it has started, 
  `ps -ef | grep _process_`


## Cluster Maintenance Tasks

### HDFS Maintenance task

  * **fsck** is used to detect corrupt file. HDFS is considered healthy if--and only if, all files have minimum numbers of replica available.
  `sudo -u hdfs hdfs fsck /`

  To make output more readable
  `sudo -u hdfs fsck / | grep -v -E '^\.'`

  * Balancing HDFS Block Data: this is needed because of
    1. Addition of new datanode
    2. Mass deletion of data
    3. Unevenly colocated clients.
    
    **Balancer** can be used to spread the data across the cluster. 
    `hadoop balancer -threshold _N_`
    This task consumes lot of network BW, so it can be capped to avoid congestion in cluster.

  * Dealing with Failed Disk
    Disk is healthy if (dfs.data.dir & mapred.local.dir):
    1. The specific path is a directory
    2. The directory exist
    3. The directory is readable
    4. The directory is writable  


### MapReduce Maintenance Tasks

  * Before starting task tracker we should start datanode so that data will not be streamed over the network.

  * Sometimes one have to kill mapreduce jobs, to do that:
    1. Become superuser
    2. hadoop job -list
    3. hadoop job -kill _jobID_

  * TO kill only task and not whole job:
    1. Become super user of owner of that job
    2. hadoop job -list-attempt-ids _jobID_, _taskType_, _taskState_
    3. hadoop job -kill-task taskAttemptId
    
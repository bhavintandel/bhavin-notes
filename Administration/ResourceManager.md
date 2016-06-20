# Resource Manager

It controls the resource allocation to given users. Resources means disk space consumption, number of files in HDFS, map & reduce slot usage.

### HDFS Quotas

We can specify the disk space a user or group is allowed to use in HDFS. For Instance,
`hdfs dfsadmin -setSpaceQuota 10737418240 /user/theOne`

We can check the quota by, 
`hdfs dfs -count -q /user/theOne`

![Image of quota]()

To clear the quotas, `hdfs dfsadmin -clrSpaceQuota`

It makes sense to assign to specify quotas in multiple of block size.
It first checks post-replication size and then allow the further storage.
![Image of error]()
![Image of success]()

HDFS also support number of files quota in a directory and can be set using,
`hdfs dfsadmin -setQuota number _path_` & _clrQuota_ to clear it.


### MapReduce Schedulers

In MapReduce, a scheduler- a plug-in within a jobtracker--is responsible to assigning tasks to open slot on tasktrackers.

JobTracker find the map task which it can launch at current machine which means that the execution of task in not in order. Also JT contacts namenode to get replica locations.

#### FIFO Scheduler

It provides 5 level of prioritization:
1. very low
2. low
3. normal
4. high
5. very high
Each priority is implemented as seperate FIFO queue. So it can be seen that it is not efficient because if high priority jobs keep on being submitted than normal queue will never be executed.

#### Fair Scheduler

<property>
 <name>yarn.resourcemanager.scheduler.class</name>
 <value>org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler</value>
</property>


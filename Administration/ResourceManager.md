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

First minimum share is allocated and then available resoources are distributed fairly among other jobs. Also there is a concept of _weight_, a pool with higher weight recieves more resources.
Effect of pool weight is not apparent until the total demand with greater than total capacity. Job priorities is implemented using weight.

Important points:
  * Minimum share before fair share.
  * Pool never recieves more than its demand, also if they have min share.
  * During fair share, fill the glasses evenly.
  * Pools can have weights.

If multiple jobs are submitted in a same pool, Fair Scheduler uses another instance of itself to scheduler jobs within the pool. We can implement FIFO within a pool. If pool's min share is given to other pools for cluster utilization and a new job is submitted to the min share pool then Fair scheduler preempt the tasks and steal the slots back to fulfill starved pool min share.

There are two kind of preemptions:
  1. Minimum Share (preeemption is harsh)
  2. Fair Share 

Also it has _delayed task assignment_ concept which let one slot of task tracker to be left empty for data locality in future.

##### To configure Fair Scheduler
Two parts need to be set:
  1. _mapred-site.xml_
  2. Separate file for pool configuration (allocations.xml)

It also has property called _sizebasedweight_ which adjust the weight of the pool according to the demand.
Also it can accept multiple jobs in single heartbeat

<property>
 <name>yarn.resourcemanager.scheduler.class</name>
 <value>org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler</value>
</property>


#### Capacity Scheduler

It have multiple queues with predefined resources same as fair scheduler but it reserves for the queue and is not given away in the absence of demand. Most starved queues receives the slot first during the heartbeat. Queue starvation = running task in queue / queue capacity. 
Inside the Queue, FIFO is used. Most significant feature is it can assign resources based on physical machine resources.
Admin can decide default virtual and physical memory limit which can be overriden upon job submission.


##### To configure Capacity Scheduler
Two parts need to be modified:
  1. _mapred-site.xml_
  2. capacity-scheduler.xml

You can configure many factors:
  1. Slots used by user within queue
  2. maximum active task in queue
  3. maximum active task per user in a queue
  4. number of job submitted to the queue. (default = 10, 45% of 5000 * 10 = 22500 after which it will start rejecting)
  5. worker-thread which should be equal to number of queues.
  6. maximum system job

Example: capacity-scheduler.xml
```xml
<?xml version="1.0"?>

<!-- This is the configuration file for the resource manager in Hadoop. -->
<!-- You can configure various scheduling parameters related to queues. -->
<!-- The properties for a queue follow a naming convention,such as, -->
<!-- mapred.capacity-scheduler.queue.<queue-name>.property-name. -->

<configuration>

  <property>
    <name>mapred.capacity-scheduler.queue.default.capacity</name>
    <value>100</value>
    <description>Percentage of the number of slots in the cluster that are
      to be available for jobs in this queue.
    </description>    
  </property>
  
  <property>
    <name>mapred.capacity-scheduler.queue.default.maximum-capacity</name>
    <value>-1</value>
    <description>
	maximum-capacity defines a limit beyond which a queue cannot use the capacity of the cluster.
	This provides a means to limit how much excess capacity a queue can use. By default, there is no limit.
	The maximum-capacity of a queue can only be greater than or equal to its minimum capacity.
        Default value of -1 implies a queue can use complete capacity of the cluster.

        This property could be to curtail certain jobs which are long running in nature from occupying more than a 
        certain percentage of the cluster, which in the absence of pre-emption, could lead to capacity guarantees of 
        other queues being affected.
        
        One important thing to note is that maximum-capacity is a percentage , so based on the cluster's capacity
        the max capacity would change. So if large no of nodes or racks get added to the cluster , max Capacity in 
        absolute terms would increase accordingly.
    </description>    
  </property>
  
  <property>
    <name>mapred.capacity-scheduler.queue.default.supports-priority</name>
    <value>false</value>
    <description>If true, priorities of jobs will be taken into 
      account in scheduling decisions.
    </description>
  </property>

  <property>
    <name>mapred.capacity-scheduler.queue.default.minimum-user-limit-percent</name>
    <value>100</value>
    <description> Each queue enforces a limit on the percentage of resources 
    allocated to a user at any given time, if there is competition for them. 
    This user limit can vary between a minimum and maximum value. The former
    depends on the number of users who have submitted jobs, and the latter is
    set to this property value. For example, suppose the value of this 
    property is 25. If two users have submitted jobs to a queue, no single 
    user can use more than 50% of the queue resources. If a third user submits
    a job, no single user can use more than 33% of the queue resources. With 4 
    or more users, no user can use more than 25% of the queue's resources. A 
    value of 100 implies no user limits are imposed. 
    </description>
  </property>
  <property>
    <name>mapred.capacity-scheduler.queue.default.maximum-initialized-jobs-per-user</name>
    <value>2</value>
    <description>The maximum number of jobs to be pre-initialized for a user
    of the job queue.
    </description>
  </property>

  <!-- The default configuration settings for the capacity task scheduler -->
  <!-- The default values would be applied to all the queues which don't have -->
  <!-- the appropriate property for the particular queue -->
  <property>
    <name>mapred.capacity-scheduler.default-supports-priority</name>
    <value>false</value>
    <description>If true, priorities of jobs will be taken into 
      account in scheduling decisions by default in a job queue.
    </description>
  </property>
  
  <property>
    <name>mapred.capacity-scheduler.default-minimum-user-limit-percent</name>
    <value>100</value>
    <description>The percentage of the resources limited to a particular user
      for the job queue at any given point of time by default.
    </description>
  </property>

  <property>
    <name>mapred.capacity-scheduler.default-maximum-initialized-jobs-per-user</name>
    <value>2</value>
    <description>The maximum number of jobs to be pre-initialized for a user
    of the job queue.
    </description>
  </property>


  <!-- Capacity scheduler Job Initialization configuration parameters -->
  <property>
    <name>mapred.capacity-scheduler.init-poll-interval</name>
    <value>5000</value>
    <description>The amount of time in miliseconds which is used to poll 
    the job queues for jobs to initialize.
    </description>
  </property>
  <property>
    <name>mapred.capacity-scheduler.init-worker-threads</name>
    <value>5</value>
    <description>Number of worker threads which would be used by
    Initialization poller to initialize jobs in a set of queue.
    If number mentioned in property is equal to number of job queues
    then a single thread would initialize jobs in a queue. If lesser
    then a thread would get a set of queues assigned. If the number
    is greater then number of threads would be equal to number of 
    job queues.
    </description>
  </property>

</configuration>
```

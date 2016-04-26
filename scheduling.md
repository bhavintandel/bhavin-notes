### Fair Scheduler
 
 #### Basics
  * Decision is based only on memory but it is possible to with considering both CPU & memory
  * Groups jobs into _"pools"_
  * Assign each pool a gauranteed minimum shares
  * Divide excess capacity evenly between pools

 #### Pools
  * Determined from a configurable job property
    * Default in 0.20: username(one pool per user)
  * Pool properties:
    * Minimum Mapper
    * Minimum Reducer
    * Limit on number of running jobs

 #### Scheduling Algorithm
  * Split each pool's min share among its jobs
  * Split each pool's total share among its jobs
  * When slot need to be assign:
    * __If__ job is below min share, schedule it
    * __Else__ schedule the job that we have been most unfair to

 #### Installation of Fair Scheduler
  * Assign the appropriate scheduler class in __yarn-site.xml__:
```xml
<property>
  <name>yarn.resourcemanager.scheduler.class</name>
  <value>org.apache.hadoop.yarn.server.resourcemanager.scheduler.fair.FairScheduler</value>
</property>
```


### Capacity Scheduler

  * It reserves the queue for small jobs and so cluster is not fully utilized.
  * __Queue Elasticity__ is behaviour which means that it can allocate available resources to waiting jobs even if it causes queue's capacity to be exceeded.

![Image of Scheduling](https://www.safaribooksonline.com/library/view/hadoop-the-definitive/9781491901687/images/hddg_0403.png)

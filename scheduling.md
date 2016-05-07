### [Fair Scheduler](https://www.safaribooksonline.com/library/view/hadoop-the-definitive/9781491901687/ch04.html)
 
#### Basics
  * Decision is based only on memory but it is possible to with considering both CPU & memory
  * Groups jobs into _"pools"_
  * Assign each pool a gauranteed minimum shares
  * Divide excess capacity evenly between pools
  * By default __CDH__ has fair scheduler.

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
  * ![Image of fair scheduler](https://www.safaribooksonline.com/library/view/hadoop-the-definitive/9781491901687/images/hddg_0404.png)

#### Installation of Fair Scheduler
  * Assign the appropriate scheduler class in _yarn-site.xml_:
```xml
<property>
  <name>yarn.resourcemanager.scheduler.class</name>
  <value>org.apache.hadoop.yarn.server.resourcemanager.scheduler.fair.FairScheduler</value>
</property>
```
  * Then create file fair-scheduler.xml
```xml
<?xml version="1.0"?>
<allocations>
  <queue name="test">
    <minResources>1000 mb, 1 vcores</minResources>
    <maxResources>5000 mb, 1 vcores</maxResources>
    <maxRunningApps>10</maxRunningApps>
    <aclSubmitApps>hdfs,gpadmin</aclSubmitApps>
    <weight>2.0</weight>
    <schedulingPolicy>fair</schedulingPolicy>
    <queue name="test-sub">
        <aclSubmitApps>root</aclSubmitApps>
        <minResources>500 mb, 1 vcores</minResources>
    </queue>
  </queue>
  <user name="root">
    <maxRunningApps>10</maxRunningApps>
  </user>
 <user name="hdfs">
    <maxRunningApps>5</maxRunningApps>
  </user>
  <user name="gpadmin">
    <maxRunningApps>5</maxRunningApps>
  </user>
  <userMaxAppsDefault>5</userMaxAppsDefault>
 <fairSharePreemptionTimeout>30</fairSharePreemptionTimeout>
</allocations>
```


### Capacity Scheduler

  * It reserves the queue for small jobs and so cluster is not fully utilized.
  * __Queue Elasticity__ is behaviour which means that it can allocate available resources to waiting jobs even if it causes queue's capacity to be exceeded.

![Image of Scheduling](https://www.safaribooksonline.com/library/view/hadoop-the-definitive/9781491901687/images/hddg_0403.png)
  
  * This is one example of capacity scheduler with dev and prod as two queues:
```xml
<?xml version="1.0"?>
<configuration>
  <property>
    <name>yarn.scheduler.capacity.root.queues</name>
    <value>prod,dev</value>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.dev.queues</name>
    <value>eng,science</value>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.prod.capacity</name>
    <value>40</value>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.dev.capacity</name>
    <value>60</value>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.dev.maximum-capacity</name>
    <value>75</value>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.dev.eng.capacity</name>
    <value>50</value>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.dev.science.capacity</name>
    <value>50</value>
  </property>
</configuration>
```




[__Document of fair share__](http://www.valleytalk.org/wp-content/uploads/2013/03/fair_scheduler_design_doc.pdf)
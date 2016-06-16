## Authorization

### HDFS

It uses same authorization as POSIX filesystems. Each file has owner, group and others. Also we have a sticky bit concept in HDFS which enables power to delete and rename a file to only the owner of the file.

### MapReduce

It has four kind of users:

  1. Cluster Owner : OS user that started the cluster ie., the user the jobtracker daemon s running as. _hadoop_ in Apache and _mapred_ in CDH. 
  2. Cluster Administrator : It has al power as Cluster owner but do not need to autthenticate as linux user who started the cluster.
  3. Queue Administrator : when submitting job, user specifies _queue_. Queue has ACL that defines the groups or user allowed to submit the job. Admin action can be changing the priorities, killing the job etc.
  4. Job Owner : The one who submits the job.

Cluster owner is automatically defines when the job tracker runs. 2 & 3 are defined by _mapred-site.xml_ & _mapred-queue-acls.xml_. It consists of two lists, first one indicated users and second one shows groups that are allowed. 

We need to add following property to mapred-site.xml file to enable ACL for queue:
  1. mapred.acls.enabled : true
  2. mapred.cluster.admiistrators : defines users and groups
  3. mapred.queue.names : name of queues separated by comma

Then, we need to define acl for queues in mapred-queue-acls.xml file: 
We have to use two privileges, acl-submit-job & acl-administer-jobs for instance,
```xml
<property>
  <name>mapred.queue.queue-name.acl-submit-job</name>
  <value>bob prod</value>
</property>
```



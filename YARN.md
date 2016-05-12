## YARN (Yet Another Resource Manager)

It was introduced to distribute the load of job tracker to efficiently manage the resources. IT provides API for requesting and working with cluster resources.
But it is not directly used by user code, instead users write to higher level APT like the following diagram. MapReduce, Spark, Tez are distributed computing frameworks. While pig, hive and cruch are processing framework. 
![Yarn Application](https://www.safaribooksonline.com/library/view/hadoop-the-definitive/9781491901687/images/hddg_0401.png)
Following figure show the workflow of an application by YARN.
![How Yarn run an application](https://www.safaribooksonline.com/library/view/hadoop-the-definitive/9781491901687/images/hddg_0402.png)
A client contacts the RM and ask to run an _application master_ which is launch in container by node manager. It could request for more conatiner. AM sends status updates to client.


#### Resource Requests

A request for set of containers can express the amount of computer resources required for each continer (memory and CPU) as well as locality constraints. Locality is critical to efficiently use bandwidth. Sometimes these constrains are not met and so container is launched in same rack.
An application can make request for resources up front, or it can take a dynamic approach. Spark make all the requests upfront.


#### Application Lifespan

There are variable lifetime of an applications, which can last few seconds or even many days. 
Model 1: Mapreduce takes this approach that is one application per user job.
Model 2: Run one application per workflow or user session of jobs. Spark use this model.
Model 3: Long runnning job that is shared by different users. For ex. __Apache Slider__ has long running AM which launches other applications on the cluster. 


#### Building YARN Applications

Spark, Samza or Storm is great for stream processing which will implement DAG jobs. Apache Slider allows user to run existing distributed applications on YARN. It provides control to change the number of nodes an application is running on. 
__Apache Twill__ is similar to Slider but is provide addition feature to develop distributed application.



## YARN Compared to MapReduce 1

In MR1 job tracker takes care of job scheduling and task progress monitoring while in YARN it is splitted between Resource manager and Application Master. In YARN, timeline server stores application history.

MapReduce 1 | YARN
------------|-------
Jobtracker | Resource manager, application master, timeline server
Tasktracker | Node manager
Slot | Container



## Scheduling in YARN


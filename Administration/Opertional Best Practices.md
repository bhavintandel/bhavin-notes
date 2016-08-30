##  Operational Best Practices - Partner Solution Engineer Sean Roberts @seano 
### Plan - Cluster Design
  
  1. More is better than bigger when it comes to nodes

  2. Component Layer
    * Master Components
      Distribute across racks to spread risk
      As cluster grow distribution change

    * Worker components
      Typically same everywhere.

  3. Component Layout

    * Multiple gateway nodes : Knox (load balanced) - Amabari views, package repo, Knox, SSH 

    * 5 Zookeepers for greater reliability (default is 3), >5 then slow

    * Layout of External databases:
      Ambari: PostgreSQL
      Hive: MySQL
      Oozie: Derby
      Ranger: MySQL

      Use same servers if possible


  4. Development cycle
      Development -> Staging -> Production
      Cloud: for scale up/down 
      If Prod has Kerberos, HA then dev should too 
  
   __Carving out master nodes on small cluster is not required. We can use master as datanode__

  
### Plan - Hardware Selection
  
  1. Sizing (Worker Node):
    * CPU: 8-12 cores each
    * RAM: 128GB (typical) or 256GB (not uncommon)
    * HDFS: 8-12 x 2-3TB
    	  4TB+ for storage archive focus

  __Falcon have capability to backup the data into the cloud.__


  2. Sizing Storm & Kafka
    * Colocate both- Storm is __compute__ and Kafka is __disk__ bound.
    * Hardware same as Worker with 128GB min RAM.
    * 4-6 disks enough for most kafka assuming 2-3 days of log retention.


  3. Storage Configuration
    * Master nodes: RAID-10, O/S + Data disks
    * Data node HDFS: RAID-0 per disk or JBOD
    * Data nodes: Single O/S disk or RAID-1 in small cluster 


  4. Storage Calculator
    * Total Storage =
      (Initial size +
       YOY Growth +
       Intermediate Data Size
       X Replication factor
       X 1.2) / Compression Ratio

    * Golden Rule of thumb
      Replication count = 3
      Compression ratio = 3-4
      Intermediate Data size = 30%~50% of raw data size

  5. Network design    
    * Be prepared for overhead from node failure.
    * Switches dedicated to cluter only!


### Provision & Deploy

  1. Automate!
    * Cluster extends to 100s or 1000s of nodes.

  2. Provisioning 
    * **Infrastructure**
      * Packages available locally
      * Red Hat Channel, Spacewalk, automate the process of Red Hat registration.
      * Automate Hostname resolution (/etc/hosts)
      * Time server (_never virtualize this_)


    * **Prepare your nodes**
      * Burn in!
      * CPUs & Drive cache at same time: hdparm -T /dev/sda
      * Network negotiation:
        * Negotiation: `ethtool eth0 | grep Speed, mii-tool, dmesg`
        * Errors: `ifconfig | grep errors`
        * Performance: `iperf`
      * Disk formatting & mounts
        * By default 5% of space reserved for root.
        * Disable: `mkfs.ext4 -m 0` or `tune2fs -m 0`
      * File Handler Limits: 
        * raise nofile & noproc in /etc/limits.conf or /etc/security/limits.conf
      * Disable THP(Transparent Huge Pages)
      * Disable IPvs
      * No swappiness 

  3. Deployment
    * Ambari blueprints for consistency 

  4. Post Deployment Consideration

    * Namenode HA (Additional dfs.namenode.data.dirs)
    * ResourceManager HA
    * AD/LDAP integration
    * Security integrations
    * Capacity scheduler
    * Document how to use it.

  
### Cluster Validation
  * Ambari Smoke Tests are run automatically.
  * terasort
  * DFSIO
  * HiBench
  * If using cloud check them (g3, s3, swift)

### Tuning: Namenode
  * Heap size needs to be tuned as cluter grows:
    * thumb rule: 200 bytes per object 
      * another thumb rule: 1.3GB per 1PB of data
    * Young generation space ~1/8 of total heap

  * Use parallel GC

  * **Storm** need to run all task at same time and so we need to check total slots available.

  * **Kafka**: Disk space avialable and lag btw read and writes.

  * **Log**: 

### Backup & HA
  * Namenode:
     * Can add additional metadata mounts (dfs.namenode.data.dir) 

  * HDFS:
     * Don't disable Trash! (use expunge period)
     * Use Snapshots
     * Replicate using Falcon, distcp

### Adding new node
  * Add them in groups
  * Rebalance after adding


### Secure
  * Kerberise the cluster as it is integrated with ambari.
  * Integrate with AD.
  * Add Knox for perimeter security. 


### Tenant onboarding
  * Bringing new project, user, group to cluster.

 [Here is the link to presentation](https://github.com/seanorama/workshop-hadoop-ops) 





    	     

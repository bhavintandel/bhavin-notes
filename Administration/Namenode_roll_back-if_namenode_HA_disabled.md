# Namenode roll back (if namenode HA disabled)

## Export the variables

export AMBARI_USER=ambari
export AMBARI_PW=ambari
export AMBARI_PORT=8080
export AMBARI_PROTO=http
export CLUSTER_NAME=POC
export NAMENODE_HOSTNAME=bmaster1.cloudwick.com
export ADDITIONAL_NAMENODE_HOSTNAME=bmaster2.cloudwick.com
export SECONDARY_NAMENODE_HOSTNAME=bmaster2.cloudwick.com
export JOURNALNODE1_HOSTNAME=bmaster1.cloudwick.com
export JOURNALNODE2_HOSTNAME=bmaster2.cloudwick.com
export JOURNALNODE3_HOSTNAME=bdatanode1.cloudwick.com


# To get zookeeper is on or not

[root@bmaster1 ~]# curl -u admin:admin -H "X-Requested-By: ambari" -i http://localhost:8080/api/v1/clusters/POC/host_components?HostRoles/component_name=ZKFC           

# To get running ha services

[root@bmaster1 ~]# /var/lib/ambari-server/resources/scripts/configs.sh -u admin -p admin -port 8080 get localhost POC hdfs-site

## Following need to be deleted

dfs.nameservices

dfs.client.failover.proxy.provider.POC

dfs.ha.namenodes.POC

dfs.ha.fencing.methods

dfs.ha.automatic-failover.enabled

dfs.namenode.http-address.POC.nn1

dfs.namenode.http-address.POC.nn2

dfs.namenode.rpc-address.POC.nn1

dfs.namenode.rpc-address.POC.nn2

dfs.namenode.shared.edits.dir

dfs.journalnode.edits.dir

dfs.journalnode.http-address

dfs.journalnode.kerberos.internal.spnego.principal

dfs.journalnode.kerberos.principal

dfs.journalnode.keytab.file

while read p; do
  echo $p
done <haServices.txt

/var/lib/ambari-server/resources/scripts/configs.sh -u admin -p admin -port 8080 delete localhost POC hdfs-site property_name



## To change core-site file
/var/lib/ambari-server/resources/scripts/configs.sh -u admin -p admin -port 8080 get localhost POC core-site

## To delete ha.zookeeper
[root@bmaster1 ~]# /var/lib/ambari-server/resources/scripts/configs.sh -u admin -p admin -port 8080 delete localhost POC core-site ha.zookeeper.quorum

## To revert the property fs.defaultFS to the NameNode host value, on the Ambari Server host:

/var/lib/ambari-server/resources/scripts/configs.sh -u admin -p admin -port 8080 set localhost POC core-site fs.defaultFS hdfs://bmaster1.cloudwick.com

## To check fs.defaultFS

/var/lib/ambari-server/resources/scripts/configs.sh -u admin -p admin -port 8080 get localhost POC core-site

 
 # 2 Recreate the Standby NameNode

 ## To check to see if you need to recreate the standby NameNode, on the Ambari Server host:

curl -u admin:admin -H "X-Requested-By: ambari" -i -X GET http://localhost:8080/api/v1/clusters/POC/host_components?HostRoles/component_name=SECONDARY_NAMENODE


#  3 Re-enable the Standby NameNode

curl -u admin:admin -H "X-Requested-By: ambari" -i -X '{"RequestInfo":{"context":"Enable Secondary NameNode"},"Body":{"HostRoles":{"state":"INSTALLED"}}}'http://localhost:8080/api/v1/clusters/POC/hosts/bmaster2.cloudwick.com/host_components/SECONDARY_NAMENODE

## To check if installed

[root@bmaster1 ~]# curl -u admin:admin -H "X-Requested-By: ambari" -i -X GET "ttp://localhost:8080/api/v1/clusters/POC/host_components?HostRoles/component_name=SECONDARY_NAMENODE&fields=HostRoles/state"


#  4 Delete All JournalNodes

## To check to see if you need to delete JournalNodes, on the Ambari Server host:

curl -u admin:admin -H "X-Requested-By: ambari" -i -X GET http://localhost:8080/api/v1/clusters/POC/host_components?HostRoles/component_name=JOURNALNODE

## To delete the JournalNodes, on the Ambari Server host:

curl -u admin:admin -H "X-Requested-By: ambari" -i -X DELETE http://localhost:8080/api/v1/clusters/POC/hosts/bmaster1.cloudwick.com/host_components/JOURNALNODE curl -u admin:admin -H "X-Requested-By: ambari" -i -X DELETE http://localhost:8080/api/v1/clusters/POC/hosts/bmaster2.cloudwick.com/host_components/JOURNALNODE curl -u admin:admin -H "X-Requested-By: ambari" -i -X DELETE http://localhost:8080/api/v1/clusters/POC/hosts/bdatanode1.cloudwick.com/host_components/JOURNALNODE 

# 5 Delete the Additional NameNode

## To check to see if you need to delete your Additional NameNode, on the Ambari Server host:

curl -u admin:admin -H "X-Requested-By: ambari" -i -X GET http>://localhost:8080/api/v1/clusters/POC/host_components?HostRoles/component_name=NAMENODE

## To delete the Additional NameNode that was set up for HA, on the Ambari Server host:

curl -u admin:admin -H "X-Requested-By: ambari" -i -X DELETE http://localhost:8080/api/v1/clusters/POC/hosts/bmaster2.cloudwick.com/host_components/NAMENODE






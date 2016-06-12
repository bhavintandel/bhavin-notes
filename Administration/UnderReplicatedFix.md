## To fix Under replicated blocks 

```sh
[root@bmaster1 ~]# sudo -u hdfs hdfs fsck / | grep 'Under replicated' | awk -F':' '{print $1}' >> /tmp/under_replicated_files
```

```sh
[root@bmaster1 ~]# sudo -u hdfs for hdfsfile in `cat /tmp/under_replicated_files`; do echo "Fixing $hdfsfile :" ;  hadoop fs -setrep 3 $hdfsfile; done
```

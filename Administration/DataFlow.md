## Data Flow
  * ![Anatomy of a File Read](http://4.bp.blogspot.com/-2To_dZQVJcI/UaSQEXu3qgI/AAAAAAAAOpk/3Lj-dHEcw_o/s1600/HDFS_Client_Read_File.png)
  * Client call _open()_ on FileSystem object, which is DFS instance whih inturns calls the namenode, using RPC (Remote Procedure Call).
  * ![Anatomy of File Write(http://3.bp.blogspot.com/-agIy454k14Y/U9Znrz_Qf9I/AAAAAAAABaw/fRuCUkt9Rbk/s1600/write-hdfs.png)
  * ![Replication](http://image.slidesharecdn.com/hadoophdfs-detailedintroduction-130319015949-phpapp01/95/hadoop-hdfs-detailed-introduction-24-638.jpg?cb=1363701612)

## Parallel Copying with distcp
_distcp_ is a MapReduce job where work of copy is done in parallel across the cluster.
By default __20__ map is used but this can be changed using -m argument.
```sh
% hadoop distcp file1 file2
% hadoop distcp dir1 dir2
```
If _dir2_ already exist then directory structure is created.
To copy the files across the cluster
```sh
% hadoop distcp -update -delete -p hdfs://namenode1/foo hdfs://namenode2/foo
```
-update argument only change the files those are modified.
-delete flag removes files from destination if not present in source.

If two cluster is using incompatible versions then we can use _webhdfs_.

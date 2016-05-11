### Command Line Interface

  * We set _fs.defaultFS_ to __hdfs://localhost/__ which configure hadoop to use HDFS by default.
  * HDFS port is 8020 where client can use to contact namenode.
  * We can mount HDFS on local client's filesystem using __NFSv3__ gateway.

### Commands
  
##### To copy files from local
  * `hdfs dfs -copyFromLocal tmp/file.txt hdfs://localhost/user/tom/file.txt`
  * We can omit the schema and use the default specified in _core-site.xml_.

##### To copy files from remote
  * `hdfs dfs -copyToLocal /user/file.txt /tmp/file.copy.txt`

  * Directories in hdfs is not affected by replication factor, it is treated as
  metadata and stored by namenode, not datanode.


### Java Interface

##### Reading data from a Hadoop URL
  * Simplest way is to use _java.net.URL_ object to open stream. But if other program has set _URLStreamHandlerFactory_ then we cannot access it.
```java
public class URLCat {
  static {
	URL.setURLStreamHandlerFactory(new FsUrlStreamHandlerFactory());
  }
  public static void main(String[] args) throws Exception {
   InputStream in = null;
   try {
	in = new URL(args[0]).openStream();
	IOUtils.copyBytes(in, System.out, 4096, false);
   } finally {
	IOUtils.closeStream(in);
   }
  }
}
```

  * To run the above program
```sh
% export HADOOP_CLASSPATH=hadoop-examples.jar
% hadoop URLCat hdfs://localhost/user/tom/quangle.txt
```


##### Reading data using FileSystem API
  * As above will lead to conflict we can use the following to get FileSystem instance:
```java
   public static FileSystem get(Configuration conf) throws IOException
OR public static FileSystem get(URI uri, Configuration conf) throws IOException
OR public static FileSystem get(URI uri, Configuration conf, String user) throws IOException
```

  * After this we can invoke open() method to get input stream.
  * One can also call seek() method to find position in the file. But this operation is very expensive.


##### Writing data
  * Following example illustrate the copying of local file to hadoop filesystem
```java
public class FileCopyWithProgress {
 public static void main(String[] args) throws Exception {
  String localSrc = args[0];
  String dst = args[1];
  InputStream in = new BufferedInputStream(new FileInputStream(localSrc));
  Configuration conf = new Configuration();
  FileSystem fs = FileSystem.get(URI.create(dst), conf);
  OutputStream out = fs.create(new Path(dst), new Progressable() {
   public void progress() {
    System.out.print(".");
   }
 };
 IOUtils.copyBytes(in, out, 4096, true);
 }
}
```
  * No other FS system support progress() method during writes.
  * To call the above program
```sh
% hadoop FileCopyWithProgress input/docs/1400-8.txt
hdfs://localhost/user/tom/1400-8.txt
```


##### Listing file
```java
public class ListStatus {
  public static void main(String[] args) throws Exception {
    String uri = args[0];
    Configuration conf = new Configuration();
    FileSystem fs = FileSystem.get(URI.create(uri), conf);
    Path[] paths = new Path[args.length];
    for (int i = 0; i < paths.length; i++) {
       paths[i] = new Path(args[i]);
    }
    FileStatus[] status = fs.listStatus(paths);
    Path[] listedPaths = FileUtil.stat2Paths(status);
    for (Path p : listedPaths) {
       System.out.println(p);
    }
  }
}
```
  * Output will be:
```sh
% hadoop ListStatus hdfs://localhost/ hdfs://localhost/user/tom
hdfs://localhost/user
hdfs://localhost/user/tom/books
hdfs://localhost/user/tom/quangle.txt
```

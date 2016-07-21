#!/bin/bash
ambari-server stop
ambari-agent stop
pkill -9 java
#################################
# Remove Packages
################################

yum  -y remove ambari-\*
yum -y remove hcatalog\*
yum -y remove hive\*
yum -y remove hbase\*
yum -y remove zookeeper\*
yum -y remove oozie\*
yum -y remove pig\*
yum -y remove snappy\*
yum -y remove hadoop-lzo\*
yum -y remove knox\*
yum -y remove hadoop\*
yum -y remove bigtop-jsvc.x86_64
yum -y remove extjs-2.2-1 mysql-connector-java-5.0.8-1\*
yum -y remove lzo.x86_64
yum -y remove extjs.noarch
yum -y remove sqoop.noarch hadoop.x86_64
yum -y remove hcatalog.noarch
yum -y remove ganglia-gmond-modules-python.x86_64
yum -y remove hadoop-libhdfs.x86_64
yum -y remove hbase.noarch
yum -y remove ambari-log4j.noarch
yum -y remove oozie-client.noarch
yum -y remove pig.noarch hive.noarch
yum -y remove hadoop-lzo.x86_64
yum -y remove hadoop-lzo-native.x86_64
yum -y remove hadoop-sbin.x86_64
yum -y remove libconfuse.x86_64
yum -y remove lzo.x86_64
yum -y remove hadoop-native.x86_64
yum -y remove hadoop-pipes.x86_64
yum -y remove zookeeper.noarch
yum -y remove libganglia.x86_64
yum -y remove ganglia-gmond.x86_64
yum -y remove lzo-devel.x86_64
yum -y remove oozie.noarch
yum -y remove extjs.noarch
yum -y remove compat-readline5.x86_64
yum -y remove rrdtool.x86_64
yum -y remove ganglia-web.noarch
yum -y remove python-rrdtool.x86_64
yum -y remove nagios.x86_64
yum -y remove ganglia-devel.x86_64
yum -y remove perl-Digest-HMAC.noarch
yum -y remove perl-Crypt-DES.x86_64
yum -y remove ganglia-gmetad.x86_64
yum -y remove nagios-www.x86_64
yum -y remove perl-Net-SNMP.noarch
yum -y remove nagios-plugins.x86_64
yum -y remove nagios-devel.x86_64
yum -y remove perl-Digest-SHA1.x86_64
yum -y remove fping.x86_64
yum -y remove perl-rrdtool.x86_64
yum -y remove webhcat-tar-pig.noarch
yum -y remove webhcat-tar-hive.noarch
yum –y remove bigtop-jsvc.x86_64
yum –y remove snappy.x86_64
yum –y remove snappy-devel.x86_64
yum –y remove bigtop-tomcat.noarch
yum -y remove ruby ruby-irb ruby-libs ruby-shadow ruby-rdoc ruby-augeas rubygems libselinux-ruby
yum -y remove ruby-devel libganglia libconfuse hdp_mon_ganglia_addons postgresql-server
yum -y remove postgresql postgresql-libs ganglia-gmond-python ganglia ganglia-gmetad ganglia-web
yum -y remove ganglia-devel httpd mysql mysql-server mysqld puppet


######################
# Remove Directories
####################
rm -rf /etc/hadoop
rm -rf /etc/hbase
rm -rf /etc/hcatalog
rm -rf /etc/hive
rm -rf /etc/ganglia
rm -rf /etc/oozie
rm -rf /etc/sqoop
rm -rf /etc/zookeeper
rm -rf /var/run/hadoop
rm -rf /var/run/hbase
rm -rf /var/run/hive
rm -rf /var/run/ganglia
rm -rf /var/run/webhcat
rm -rf /var/log/hadoop
rm -rf /var/log/hbase
rm -rf /var/log/hive
rm -rf /var/log/zookeeper
rm -rf /usr/lib/hadoop
rm -rf /usr/lib/hadoop-yarn
rm -rf /usr/lib/hadoop-mapreduce
rm -rf /usr/lib/hbase
rm -rf /usr/lib/hcatalog
rm -rf /usr/lib/hive
rm -rf /usr/lib/oozie
rm -rf /usr/lib/sqoop
rm -rf /usr/lib/zookeeper
rm -rf /var/lib/hive
rm -rf /var/lib/zookeeper
rm -rf /var/lib/hadoop-hdfs
rm -rf /hadoop/hbase
rm -rf /hadoop/zookeeper
rm -rf /hadoop/mapred
rm -rf /hadoop/hdfs
rm -rf /tmp/sqoop-ambari-qa
rm -rf /var/run/oozie
rm -rf /var/log/oozie
rm -rf /var/lib/oozie
rm -rf /var/tmp/oozie
rm -rf /hadoop/oozie
rm -rf /etc/nagios
rm -rf /var/run/nagios
rm -rf /var/log/nagios
rm -rf /usr/lib/nagios
rm -rf /var/lib/ganglia
rm -rf /tmp/nagios
rm -rf /var/nagios
rm -rf /var/log/webhcat
rm -rf /tmp/hive
rm -rf /var/run/zookeeper
rm -rf /tmp/ambari-qa
rm -rf /etc/storm
rm -rf /etc/hive-hcatalog
rm -rf /etc/tez
rm -rf /etc/falcon
rm -rf /var/run/hadoop-yarn
rm -rf /var/run/hadoop-mapreduce
rm -rf /var/log/hadoop-yarn
rm -rf /var/log/hadoop-mapreduce
rm -rf /usr/lib/hive-hcatalog
rm -rf /usr/lib/falcon
rm -rf /tmp/hadoop
rm -rf /var/hadoop
rm -rf /etc/webhcat
rm -rf /var/log/hadoop-hdfs
rm -rf /var/log/hue
rm -rf /var/lib/alternatives
rm -rf /var/lib/alternatives/flume
rm -rf /var/lib/alternatives/sqoop2
rm -rf /var/lib/alternatives/impala
rm -rf /var/lib/alternativese/hdfs
rm -rf /var/lib/alternatives/webhcat
rm -rf /var/lib/alternatives/hive
rm -rf /var/lib/alternatives/zookeeper
rm -rf /etc/alternative/hadoop
rm -rf /var/log/hadoop-hdfs
rm -rf /etc/webhcat
rm -rf /var/log/hadoop-hdfs
rm -rf /var/log/hue
rm -rf /etc/alternatives/flume
rm -rf /etc/alternative/sqoop2
rm -rf /etc/alternative/impala
rm -rf /etc/alternative/hdfs
rm -rf /etc/alternative/webhcat
rm -rf /etc/alternative/hive
rm -rf /etc/alternative/zookeeper
rm -rf /etc/alternative/hadoop


################################
# uer delete
################################

userdel -r   nagios
userdel -r   hive
userdel -r   ambari-qa
userdel -r   hbase
userdel -r   oozie
userdel -r   hcat
userdel -r   hdfs
userdel -r   mapred
userdel -r   zookeeper
userdel -r   sqoop
userdel -r   rrdcached
userdel -r   yarn
userdel -r   flume
userdel -r   hue
userdel -r   sqoop2

yum list installed | grep -i ambari

rm -rf /usr/sbin/ambari-server
rm -rf /usr/lib/ambari-server
rm -rf /var/run/ambari-server
rm -rf /var/log/ambari-server
rm -rf /var/lib/ambari-server
rm -rf /etc/rc.d/init.d/ambari-server
rm -rf /etc/ambari-server
rm -rf /usr/sbin/ambari-agent
rm -rf /usr/lib/ambari-agent
rm -rf /var/run/ambari-agent
rm -rf /var/log/ambari-agent
rm -rf /var/lib/ambari-agent
rm -rf /etc/rc.d/init.d/ambari-agent
rm -rf /etc/ambari-agent


#python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py

yum list installed | grep -i ambari

python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py --silent --skip=users

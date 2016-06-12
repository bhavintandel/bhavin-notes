### Task 1: Disabling IPv6

  * As hadoop is not supported on IPv6 and by deafult some linux machines are configured to it we should disable it
  * `service ip6tables stop` & `chkconfig ip6tables off`


### Task 2: Setup NTP

  * We need all the nodes to communicate with each other in synchronous way so we need _Network Time Protocol_.
  * `yum -y install ntp`
  * `service ntpd start` & `chkconfig ntpd on`

### Task 3: Understand SSH, SCP and RSync

  * __SSH__ stands for secure shell which encrypt message while sending over network which was not provided by Telnet.
  * Following image will give good understanding of both cases.
  * ![Img of telnet](http://support.suso.com/w/images/5/52/Telnet-Client-server-unencrypted.png)
  * ![Img of ssh](http://support.suso.com/w/images/6/68/SSH-client-server-encrypted.png)
  * [_This_](http://support.suso.com/supki/SSH_Tutorial_for_Linux) is an awesome link to understand SSH.

  * __SCP__ means secure copy. 
  * Copying file to host `scp SourceFile user@host:directory/TargetFile`
  * Copying file from host `scp user@host:directory/SourceFile TargetFile`

  * __Rsync__ stands for remote synchronization which can synchronize files between two hosts. It will just send the difference between two files.
  * [Here](http://www.tecmint.com/rsync-local-remote-file-synchronization-commands/) is perfect usages of the command.

### Task 4: Configuring FQDN for server

  * Type `vim /etc/hosts`
  * Add variable `HOSTNAME=xyz.company.com`

### Task 5: Understand Reverse DNS lookup's and hosts file


### Task 6: IPTables
  
  * We disable iptables because it can block few packets and assign it as INVALID. [This](http://aaron.blog.archive.org/2012/08/08/problems-with-hadoop-and-iptables/) link has an explaination for the same.
  * `service iptables stop` & `service iptables off`

### Task 7: SELinux

  * `setenforce 0`
  * `vim /etc/selinux/config` and change to _disabled_

### Task 8: Starting and Stopping services

  * Just use _service <Name of Application> start_ to start for instance `service mysqld start`.
  * To stop replace the work start with stop.

### Task 9: Enable services at specified run time levels

  * We use _chkconfig_ to specify enabling of services at specified run levels. This [website](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s2-services-chkconfig.html) has good explaination of it.

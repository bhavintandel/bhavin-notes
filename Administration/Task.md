### Task 1: Setup Pseudo Distributed Hadoop cluster
  #### Setup EC2 instance
    * Create Security group with inbound & outbound as TCP, ICMP, HTTP & SSH
    * Create a Key Pairs for SSH
    * Associate new Elastic IP and assign it to instance.
    * 52.10.120.212 ec2-52-10-120-212.us-west-2.compute.amazonaws.com 172.31.46.74 master1

### Task 11: Enabling services at specific runtime levels
  * Run level scripts __/etc/rc.d/rc__ are integral concept. 
    * It checks if run-level scripts are correct.
    * Determine current and previous run levels.
    * Decide whether to enter interactive startup.
    * Kills and starts run-level scripts.
  * A software that has service to start at start time can add script to __/etc/init.d__ directory.
  0 — Halt
  1 — Single-user text mode
  2 — Not used (user-definable)
  3 — Full multi-user text mode
  4 — Not used (user-definable)
  5 — Full multi-user graphical mode (with an X-based login screen)
  6 — Reboot
  * `runlevel` to check current runlevel.
  * `telinit 5` to change run level to 5.
  * `chkconfig ntpd on` to start ntpd at current runlevel.
  * [HERE](http://searchitchannel.techtarget.com/feature/Understanding-run-level-scripts-in-Fedora-11-and-RHEL) is the cool link.

### Task 12: Restricting SNN
  * [__Link__](http://stackoverflow.com/questions/17581134/restrict-secondarynamenode-to-be-installed-and-run-on-any-other-node-in-the-clus)

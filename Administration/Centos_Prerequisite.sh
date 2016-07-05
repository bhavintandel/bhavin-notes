## Prerequisite

echo "Install Basic "
yum -y update
yum -y install wget
yum -y install unzip
yum -y install curl
yum -y install tar

echo "Stop firewalls"
service iptables stop
chkconfig iptables off
service ip6tables stop
chkconfig ip6tables off

echo "Disable swappiness"
sysctl -w vm.swappiness=0
echo 0 > /proc/sys/vm/swappiness

if grep -q "echo 0 > /proc/sys/vm/swappiness" /etc/rc.local
	then echo " Swapp is disabled on boot"
	else echo "echo 0 > /proc/sys/vm/swappiness" >> /etc/rc.local
	echo "Disabling swap on boot"
fi


echo "Install and start ntpd"
yum -y install ntpd
ntpdate 0.centos.pool.ntp.org
service ntpd start
chkconfig ntpd on

echo "Updating openssl"
yum -y upgrade openssl

echo "Disabling SELINUX"
sed -i.old s/SELINUX=enforcing/SELINUX=disabled/ /etc/selinux/config
echo 0 > /selinux/enforce

echo "Disabling hugepages"
echo never > /sys/kernel/mm/transparent_hugepage/enabled

if grep -q "echo never > /sys/kernel/mm/transparent_hugepage/enabled" /etc/rc.local
	then echo "Transparent Hugepage disabled on boot"
	else echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.local
	echo "Disabling Transparent Hugepage on boot"
fi

echo "Installing mysql-connector"
yum -u install mysql-connector-java
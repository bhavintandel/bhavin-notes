# Enter optional directory
cd /opt/

# download jdk 8.91
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz"

# untar jdk
tar xzf jdk-8u91-linux-x64.tar.gz

# Enter jdk folder
cd /opt/jdk1.8.0_91/

# Install java
alternatives --install /usr/bin/java java /opt/jdk1.8.0_91/bin/java 2

# Configure java
alternatives --config java


There are 3 programs which provide 'java'.

  Selection    Command
-----------------------------------------------
*  1           /opt/jdk1.7.0_71/bin/java
 + 2           /opt/jdk1.8.0_45/bin/java
   3           /opt/jdk1.8.0_77/bin/java
   4           /opt/jdk1.8.0_91/bin/java

Enter to keep the current selection[+], or type selection number: 4

# Optional

## Setup jar and javac 

alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_91/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_91/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_91/bin/jar
alternatives --set javac /opt/jdk1.8.0_91/bin/javac

## Configuring Environment Variables

### Setup JAVA_HOME Variable
export JAVA_HOME=/opt/jdk1.8.0_91
### Setup JRE_HOME Variable
export JRE_HOME=/opt/jdk1.8.0_91/jre
### Setup PATH Variable
export PATH=$PATH:/opt/jdk1.8.0_91/bin:/opt/jdk1.8.0_91/jre/bin

Ambari java location
Path to JAVA_HOME: /usr/java/jdk1.8.0_91/

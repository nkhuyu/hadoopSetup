#!/bin/bash -x

# manually steps:
# 1. edit /etc/hostname file make host like hadoop0  hadoop1 hadoop2
# 2. copy datanodes public keys to namenode (datanodes have access to namenode)
# 3. copy namenode authorized key to all slave nodes (namenode has access to all datanodes
# and datanodes have access to itself.)

# Download Hadoop and set permissons
cd ~
if [ ! -f hadoop-2.2.0.tar.gz ]; then
    wget http://apache.osuosl.org/hadoop/common/hadoop-2.2.0/hadoop-2.2.0.tar.gz
sudo tar vxzf hadoop-2.2.0.tar.gz -C /usr/local

cd /usr/local
sudo mv hadoop-2.2.0 hadoop
sudo chown -R hduser:hadoop hadoop

# Hadoop variables
sudo sh -c 'echo export JAVA_HOME=/usr/lib/jvm/jdk/ >> /home/hduser/.bashrc'
sudo sh -c 'echo export HADOOP_INSTALL=/usr/local/hadoop >> /home/hduser/.bashrc'
sudo sh -c 'echo export PATH=\$PATH:\$HADOOP_INSTALL/bin >> /home/hduser/.bashrc'
sudo sh -c 'echo export PATH=\$PATH:\$HADOOP_INSTALL/sbin >> /home/hduser/.bashrc'
sudo sh -c 'echo export HADOOP_MAPRED_HOME=\$HADOOP_INSTALL >> /home/hduser/.bashrc'
sudo sh -c 'echo export HADOOP_COMMON_HOME=\$HADOOP_INSTALL >> /home/hduser/.bashrc'
sudo sh -c 'echo export HADOOP_HDFS_HOME=\$HADOOP_INSTALL >> /home/hduser/.bashrc'
sudo sh -c 'echo export YARN_HOME=\$HADOOP_INSTALL >> /home/hduser/.bashrc'
sudo sh -c 'echo export HADOOP_COMMON_LIB_NATIVE_DIR=\$\{HADOOP_INSTALL\}/lib/native >> /home/hduser/.bashrc'
sudo sh -c 'echo export HADOOP_OPTS=\"-Djava.library.path=\$HADOOP_INSTALL/lib\" >> /home/hduser/.bashrc'

# Modify JAVA_HOME 
cd /usr/local/hadoop/etc/hadoop
sudo -u hduser sed -i.bak s=\${JAVA_HOME}=/usr/lib/jvm/jdk/=g hadoop-env.sh

# Check that Hadoop is installed
/usr/local/hadoop/bin/hadoop version
fi

# Edit configuration files
cd /usr/local/hadoop/etc/hadoop

# core-site.xml
#sudo -u hduser sed -i.bak 's=<configuration>=<configuration>\<property>\<name>fs\.defaultFS\</name>\<value>hdfs://hadoop0:9000\</value>\</property>=g' core-site.xml

#sudo -u hduser sed -i.bak 's=<configuration>=<configuration>\<property>\<name>hadoop\.temp\.dir\</name>\<value>/tmp/hadoop/-${user.name}\</value>\</property>=g' core-site.xml

cd ~
mkdir -p mydata/hdfs/datanode
mkdir -p mydata/hdfs/namenode

cd /usr/local/hadoop/etc/hadoop

# hdfs-site.xml
sudo -u hduser sed -i.bak 's=<configuration>=<configuration>\<property>\<name>dfs\.replication</name>\<value>1\</value>\</property>\<property>\<name>dfs\.namenode\.name\.dir</name>\<value>file:/home/hduser/mydata/hdfs/namenode</value>\</property>\<property>\<name>dfs\.datanode\.data\.dir</name>\<value>file:/home/hduser/mydata/hdfs/datanode</value>\</property>=g' hdfs-site.xml

# mapred-site.xml
sudo -u hduser cp mapred-site.xml.template mapred-site.xml
sudo -u hduser sed -i.bak 's=<configuration>=<configuration>\<property>\<name>mapreduce\.framework\.name</name>\<value>yarn</value>\</property>=g' mapred-site.xml

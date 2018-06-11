#!/bin/bash
zabbix_server_ip='10.10.23.202,124.207.62.75'
#system_version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
client_server_ip=`ip a | grep -Po '(?<=inet ).*(?=\/)' | grep -v -e 127.0.0.1 -e  192.168 -e  172. -e 169.254| head -1`
cd /tmp
wget http://mirrors.aliyun.com/zabbix/zabbix/3.0/rhel/6/x86_64/zabbix-agent-3.0.3-1.el6.x86_64.rpm
#yum install -y unixODBC
rpm -ivh zabbix-agent-3.0.3-1.el6.x86_64.rpm
sed -i.bak "s/Server=127.0.0.1/Server=$zabbix_server_ip/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/ServerActive=127.0.0.1/ServerActive=$zabbix_server_ip/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/Hostname=Zabbix server/Hostname=$client_server_ip/" /etc/zabbix/zabbix_agentd.conf
chkconfig --add zabbix-agent
chkconfig zabbix-agent on
service zabbix-agent start

#!/bin/bash

function system_stats() {

date
echo""

echo -e "\e[31;43m****Hostname Information****\e[0m"
hostnamectl
echo""

echo -e "\e[31;43m****Filesystem Information****\e[0m"
df -h | sort -rnk 5 | awk '{print "Partition " $6 "\t: " $5 " full."}'
echo ""

echo -e "\e[31;43m****Memory Information****\e[0m"
free -h
echo ""

echo -e "\e[31;43m****System Uptime****\e[0m"
uptime
echo""

echo -e "\e[31;43m****User Information****\e[0m"
who -ab
echo ""

echo -e "\e[31;43m****Memory Consuming Processes****\e[0m"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 10
echo ""
}

system_stats >> /var/tmp/stats.txt

mail -s 'System Status Report' 'jhodge@benefitservices.com' < /var/tmp/stats.txt


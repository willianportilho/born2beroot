#!/bin/bash

# 01) Architecture
arch=$(uname -a)

# 02) CPU physical
n_phys=$(grep 'physical id' /proc/cpuinfo | sort | uniq | wc -l)

# 03) vCPU
n_proc=$(grep '^processor' /proc/cpuinfo | wc -l)

# 04) Memory Usage
mem_1=$(vmstat -sSm | grep 'm used memory' | tr -d ' \n' | sed 's/m.*/\//')
mem_2=$(vmstat -sSm | grep 'm total memory' | tr -d ' \n' | sed 's/m.*/MB/')
used=$(vmstat -sSm | grep 'm used memory' | tr -d ' \n' | sed 's/m.*//')
total_mem=$(vmstat -sSm | grep 'm total memory' | tr -d ' \n' | sed 's/m.*//')
mem_res=$(echo "($used * 100) / $total_mem" | bc -l | cut -b1-4 | sed 's/^/(/' | sed 's/$/%)/')

# 05) Disk Usage
disk_1=$(df -Bm --total | grep 'total' | tr " " "\n" | grep -m2 'M' | sed -n 2p | tr "M" "/" | tr -d "\n")
disk_2=$(df -h --total | grep 'total' | tr " " "\n" | grep -m1 'G' | sed 's/G/Gb/' | tr -d "\n")
disk_3=$(df -h --total | grep 'total' | tr " " "\n" | grep '%' | sed 's/^/\(/' | sed 's/$/\)/')

# 06) CPU load
cpu_per=$(mpstat | tr " " "\n" | sed -n '$p' | tr -d "\n")
cpu_res=$(echo "100 - $cpu_per" | bc -l | sed 's/^\./0./' | cut -b1-3 | sed 's/$/%/')

# 07) Last boot
boot_res=$(who -b | sed 's/^.*boot  //')

# 08) LVM use
condition_1=$(blkid | grep 'TYPE\=\"LVM' | wc -l)
lvm_res=$(if (($condition_1 != 0)); then echo "yes"; else echo "no"; fi)

# 09) Connections TCP
tcp_res=$(ss -s | grep 'estab' | sed 's/.*estab //' | sed 's/\,.*/ ESTABLISHED/')

# 10) User log
userl_res=$(who | wc -l)

# 11) Network
ip_res=$(hostname -I | sed 's/ .*//' | tr -d '\n')
mac_res=$(cat /sys/class/net/enp0s3/address | sed 's/^/\(/' | sed 's/$/\)')

# 12) Sudo
sudo_res=$(grep -c 'COMMAND=' /var/log/sudo/inputs.log/sudo.log | sed 's/$/ cmd/')

# 13) wall
wall "	#Architecture: $arch
		#CPU physical : $n_phys
		#vCPU : $n_proc
		#Memory Usage: $$mem_1$mem_2 $mem_res
		#Disk Usage: $disk_1$disk_2 $disk_3
		#CPU load: $cpu_res
		#Last boot: $boot_res
		#LVM use: $lvm_res
		#Connection TCP : $tcp_res
		#User log: $userl_res
		#Network: IP $ip_res $mac_res
		#Sudo : $sudo_res "
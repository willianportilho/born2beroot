#!/bin/bash

# 01) Architecture
arch=$(/usr/bin/uname -a)

# 02) CPU physical
n_phys=$(/usr/bin/grep 'physical id' /proc/cpuinfo | /usr/bin/sort | /usr/bin/uniq | /usr/bin/wc -l)

# 03) vCPU
n_proc=$(/usr/bin/grep '^processor' /proc/cpuinfo | /usr/bin/wc -l)

# 04) Memory Usage
mem_1=$(/usr/bin/vmstat -sSm | /usr/bin/grep 'm used memory' | /usr/bin/tr -d ' \n' | /usr/bin/sed 's/m.*/\//')
mem_2=$(/usr/bin/vmstat -sSm | /usr/bin/grep 'm total memory' | /usr/bin/tr -d ' \n' | /usr/bin/sed 's/m.*/MB/')
used=$(/usr/bin/vmstat -sSm | /usr/bin/grep 'm used memory' | /usr/bin/tr -d ' \n' | /usr/bin/sed 's/m.*//')
total_mem=$(/usr/bin/vmstat -sSm | /usr/bin/grep 'm total memory' | /usr/bin/tr -d ' \n' | /usr/bin/sed 's/m.*//')
mem_res=$(/usr/bin/echo "($used * 100) / $total_mem" | /usr/bin/bc -l | /usr/bin/cut -b1-4 | /usr/bin/sed 's/^/(/' | /usr/bin/sed 's/$/%)/')

# 05) Disk Usage
disk_1=$(/usr/bin/df -Bm --total | /usr/bin/grep 'total' | /usr/bin/tr " " "\n" | /usr/bin/grep -m2 'M' | /usr/bin/sed -n 2p | /usr/bin/tr "M" "/" | /usr/bin/tr -d "\n")
disk_2=$(/usr/bin/df -h --total | /usr/bin/grep 'total' | /usr/bin/tr " " "\n" | /usr/bin/grep -m1 'G' | /usr/bin/sed 's/G/Gb/' | /usr/bin/tr -d "\n")
disk_3=$(/usr/bin/df -h --total | /usr/bin/grep 'total' | /usr/bin/tr " " "\n" | /usr/bin/grep '%' | /usr/bin/sed 's/^/\(/' | /usr/bin/sed 's/$/\)/')

# 06) CPU load
cpu_per=$(/usr/bin/mpstat | /usr/bin/tr " " "\n" | /usr/bin/sed -n '$p' | /usr/bin/tr -d "\n")
cpu_res=$(/usr/bin/echo "100 - $cpu_per" | /usr/bin/bc -l | /usr/bin/sed 's/^\./0./' | /usr/bin/cut -b1-3 | /usr/bin/sed 's/$/%/')

# 07) Last boot
boot_res=$(/usr/bin/who -b | /usr/bin/sed 's/^.*boot  //')

# 08) LVM use
condition_1=$(/usr/sbin/blkid | /usr/bin/grep 'TYPE\=\"LVM' | /usr/bin/wc -l)
lvm_res=$(if (($condition_1 != 0)); then /usr/bin/echo "yes"; else /usr/bin/echo "no"; fi)

# 09) Connections TCP
tcp_res=$(/usr/bin/ss -s | /usr/bin/grep 'estab' | /usr/bin/sed 's/.*estab //' | /usr/bin/sed 's/\,.*/ ESTABLISHED/')

# 10) User log
userl_res=$(/usr/bin/who | /usr/bin/wc -l)

# 11) Network
ip_res=$(/usr/bin/hostname -I | /usr/bin/sed 's/ .*//' | /usr/bin/tr -d '\n')
mac_res=$(/usr/bin/cat /sys/class/net/enp0s3/address | /usr/bin/sed 's/^/\(/' | /usr/bin/sed 's/$/\)')

# 12) Sudo
sudo_res=$(/usr/bin/grep -c 'COMMAND=' /var/log/sudo/inputs.log/sudo.log | /usr/bin/sed 's/$/ cmd/')

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
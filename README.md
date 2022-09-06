<h1 align="center"> born2beroot </h1>

<p align="center"> A 42 project </p>

<p align="center">
  <img alt="status completed" src="https://img.shields.io/badge/STATUS-COMPLETED-green">
</p>

---

## Introduction

This project had the purpose to learn about virtualization and set up a server by following specific rules.

---

### Explanation

For made this project we had to use the [_virtualbox_](https://www.virtualbox.org/) program. <br>
<br>
Choose between the [Debian](https://www.debian.org/index.pt.html) system or the CentOS system. I chose Debian because is more simple and practical for begginers. <br>
Create at least 2 encrypted partitions using [LVM](https://wiki.debian.org/LVM) _(Logical Volume Manager)_ and anderstand how it works. <br>
<br>
Understand the differences between aptitude and apt and in case of Debian system, what [Apparmor](https://apparmor.net/) is. <br>
Understand how SSH service ([openssh-server](https://www.openssh.com/)) works and use this service during the evaluation. <br>
Learn about [UFW](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29) _(Uncomplicated Firewall)_ and configure specific rules. <br>
Learn about groups, users and how configure it. <br>

#### Sudo
Install and configure sudo following strict rules: <br>
- Authentication using sudo has 3 attempts; <br>
- A message is displayed in case of a wrong sudo password; <br>
- Each action using sudo is archived in /var/log/sudo/some_folder; <br>
- TTY mode is enabled; <br>
- The paths that can be used by sudo are restricted (ex: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin). <br>
<br>

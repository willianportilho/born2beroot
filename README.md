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

#### Password Policy
Set up a strong password policy: <br>
- The password expires every 30 days;
- The number of days allowed before a new password is 2;
- The user receives a warning message 7 days before their password expires;
- The password must be at least 10 characters long, being an uppercase, a lowercase and a number.
- It must not contain more than 3 consecutive identical characters;
- The name of the user it must not used.
- The password must have at least 7 characters different from the old password.

#### Sudo
Install and configure sudo following strict rules: <br>
- Authentication using sudo has 3 attempts; <br>
- A message is displayed in case of a wrong sudo password; <br>
- Each action using sudo is archived in /var/log/sudo/some_folder; <br>
- TTY mode is enabled; <br>
- The paths that can be used by sudo are restricted (ex: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin). <br>
<br>

#### Script

We had to create a [script](./monitoring.sh) that would show some informations on all logged machines.
I created more than one script. The [first](./monitoring.sh) contains all the path of the arguments and the [second](./monitoring_v2.sh), contains a simplified version, whitout all the path.
The output received on all machines is:

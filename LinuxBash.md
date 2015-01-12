###1. Filesystem
**1)navigate to an absolute path: **

$ cd /etc

$ pwd

/etc

**2)navigate to a relative path: **

$cd Applications

$pwd

/Users/xli2/Applications

###2.Everything is a File

**1) 'files' in a standard unix filesystem:**

my_pipe (named pipe)

/tmp/.X11-unix/X0 (Socket)

/dev/sda (device file)

name_service_door (door)

**2)File descriptor:**

When open a file, the operating system creates an entry to represent that file and store the information about that opened file.
So if there are 100 files opened in your OS then there will be 100 entries in OS (somewhere in kernel).
These entries are represented by integers like (...100, 101, 102..). This entry number is the file descriptor.
So it is just an integer number that uniquely represents an opened file in operating system.
When open a network socket, it is also represented by an integer and it is called Socket Descriptor.

**3)Postgres write a 'pid file'**

*name*:postmaster.pid

*content:*

15

/usr/local/var/postgres

1415373349

5432

/tmp

localhost

     5432001     65536

###3.Path and the Environment:

**1) command to view all environment variables**

$ printenv - Print all or part of environment

$ env - Print all exported environment or run a program in a modified environment

$ set - Print the name and value of each shell variable

**2)use grep to find the one called EDITOR**

$ printenv | grep EDITOR

$ export EDITOR="/usr/bin/emacs"

$ printenv:

*EDITOR=/usr/bin/emacs*

**3)echoes the value of the PATH environment variable**

echo $PATH

**4)command that will tell you the full path of the script used when you execute 'ruby'**

$ which ruby

/usr/local/bin/ruby

###4.Transferring Files Between Boxes
[SCP](https://linuxacademy.com/blog/linux/ssh-and-scp-howto-tips-tricks/)

**SSH:**
Secure SHell
, the general protocol

**ssh:**
the linux SSH client command

**1) connect to a server that supports ssh**
(make sure it is running before ssh)

$ ssh cnuapp@local.dev.cashnetusa.com

password: cnuapp

**2) transfer a file(xli2.txt) from local machine to Virtualbox**

xli2$ scp /Users/xli2/xli2.txt cnuapp@local.dev.cashnetusa.com:/home/cnuapp

**3) transfer a file from Virtualbox to local machine**

xli2$ scp cnuapp@local.dev.cashnetusa.com:xli2.txt /Users/xli2

###5.Git

###6.Managing File Permissions

[chown & chmod](http://linuxfrombeginning.wordpress.com/2008/09/25/linux-command-9-chown-chgrp-chmod/)

**$ chown** change file owner and group

**$ chgrp** change group

**$ chomd** change permissions

**$ ls -l** check the ownership of a file or directory

**1) create a file and file permissions**

$ touch xli22.txt

$ ls -l xli22.txt

-rw-r--r-- 1 **xli2**  513  21 Nov 11 11:25 xli22.txt

**permissions:**

*-rw-r—r—:* file mode

*The first dash (-)* indicates the type of file (d for directory, s for special file, and - for a regular file). 

*The next three characters (rw-)* define the owner’s permission to the file.

*The next three characters (r–)* are the permissions for the members of the same group as the file owner
 
*The last three characters (r–)* show the permissions for all other users

*1:* number of links

*xli2:* Owner name

*513:* Group name

*21:* number of bytes in the file

**2) chown to change ownership of file**

*only root can change the ownership, switch to root user:*

$ whoami

xli2

$ sudo -i

$ whoami

root

*change ownership of file 'xli22.txt' to root user*

$ chown -v root /Users/xli2/xli22.txt

$ exit

$ ls -l xli22.txt

-rw-r--r--  1 **root**  513  21 Nov 11 11:25 xli22.txt


**3) chmod to grand read and execute permissions to everyone for that file:**

xli2$ sudo -i

root# **chmod 755** /Users/xli2/xli22.txt

root# exit

xli2$ ls -l xli22.txt

**-rwxr-xr-x**  1 root  513  21 Nov 11 11:25 xli22.txt

**4) use 'symbolic syntax' to remove the ability for the root group to write the file**

xli2$ sudo -i

root# chmod a-w /Users/xli2/xli22.txt

root# exit

xli2$ ls -l xli22.txt

**-r-xr-xr-x**  1 root  513  21 Nov 11 11:25 xli22.txt

### 7.Sudo

**1) example when need sudo to run a command**

$ sudo -i

**2)example where use of sudo can get you into trouble**

no restricted privileges, may cause serious damage to the system by accident.

### 8.Monitoring System Resources

[du](http://www.linfo.org/du.html)

[df](http://www.linfo.org/df.html)

[htop](http://www.thegeekstuff.com/2011/09/linux-htop-examples/)

**du:** report the sizes of directory trees

**df:** report the amount of space used and available on currently mounted filesystems

**htop:** a process viewer

**load:** a measure of the amount of computtational work that a computer system performs

**load average:** represents the average system load over a period of time

**1) ckeck remaining disk space on laptop**

$ df -h

**2) check remaining space that directory and each subdirectory takes on disk**

$ du -sh ~

$ du -sh *

**3)check how much memory is currently being consumed on laptop, sort the running processes to see which is consuming the most resources**

$ htop

$ sort : >

consume Memory most: kernel_task

consume CPU most: WindowServer

 
**4) After running a few processor-internsive tasks on laptop**

Before: CPU Load average: 1.40 1.40

After: CPU Load average : 1.55 1.45

### 9.Port

[What is Port](https://en.wikipedia.org/wiki/Port_(computer_networking))

[Netstat Command](http://www.thegeekstuff.com/2010/03/netstat-command-examples/)

[Mac Netstat](http://www.jayway.com/2012/09/08/finding-the-pid-listening-on-a-specific-port-on-mac-os-x/)


*List all ports:* $ netstat -a | more

*List all tcp ports:* $ netstat -at

*List all udp ports:* $ netstat -au

*List only listening ports:* $ netstat -l

*List only listening TCP Ports :* netstat -lt

*List only listening UDP:* $ netstat -lu

*List only the listening UNIX Ports:* $ netstat -lx

*Show statistics for all ports:* $ netstat -s

*Show statistics for TCP:* $ netstat -st

*Show statistics for UDP:* $ netstat -su

*Display PID and program names:* $ netstat -pt

*Print netstat information continuously:* $ netstat -c

*Display the kernel routing information:* $ netstat -r

*Find out on which port a program is running:* $ netstat -ap | grep ssh

*Find out which process is using a particular port:*
$ netstat -an | grep ':80'

*Show the list of network interfaces:* $ netstat -i

*Display extended information on the interfaces(like ifconfig):* $ netstat -ie

**1) show the list of currently listening ports on your laptop:**

$ netstat -l

**2) run again on a Linux VM, include the flags to display the applications that are listening. Find the application port and pid that run sshd**

$ netstat -pt

**3) List the default ports:**

[Well-Known TCP Port Numbers](http://www.webopedia.com/quick_ref/portnumbers.asp)

**ssh:** 22 (SSH- Remote Login Protocol)

**scp:** runs over TCP port 22

**http:** 80

**https:** 443

**postgres:** 5432 (the same port number is used for all IP addresses the server listens on)

### 10. Finding, pausing and killing processes

[PS Command](http://www.thegeekstuff.com/2011/04/ps-command-examples/)

[background jobs](http://www.thegeekstuff.com/2010/05/unix-background-job/)

**$ ps -ef:** list all the process on your system

-e to display all the processes

-f to display full format listing

**$ ps -f -u xli2,postfix | grep ruby:** display all the process that are owned by user, postfix and find the PID that corresponds to ruby script

19886 23511 85663   0  9:37PM ttys000    0:00.17 ruby -e sleep 1 while true

19886 24102 85663   0 11:16PM ttys000    0:00.00 grep ruby


**$ ps -aux | grep command:** get the list of process with the given command

**&:** Append & to the command runs the job in the background

**CTRL+Z:** suspend the current foreground job

**bg:** make that command to execute in background

**jobs:** list out the background jobs

**fg:** bring a background job to the foreground

**kill %job-number:** kill a specific background job use

**kill the ruby process based on its PID:**

$ kill -9 85663

### 11. Starting and Stopping Services

[Debian](http://www.oreilly.com/openbook/debian/book/ch07_03.html)

cnuapp@local:~$ sudo apt-get install openssh-server

**1) use init scripts to restart sshd:**

[10:52:55]cnuapp@local:~$ sudo /etc/init.d/ssh start

Starting OpenBSD Secure Shell server: sshd.

[11:01:56]cnuapp@local:~$ sudo /etc/init.d/ssh stop

Stopping OpenBSD Secure Shell server: sshd.

**2)pretend you just changed your nginx config, and want to reload the changes without stopping the service altogether. Invoke the init script without any arguments to see valid choices. Now run the correct init command to parse and load the config without stopping the server.**

[11:02:56]cnuapp@local:~$ sudo /etc/init.d/ssh

Usage: /etc/init.d/ssh {start|stop|reload|force-reload|restart|try-restart|status}.

### 12. Monitoring Production Hardware

[product demo by Zenoss](https://www.youtube.com/watch?v=UjJKpDLYx18)

[Zenoss vs. Nagios](http://www.techrepublic.com/blog/linux-and-open-source/system-monitoring-with-zenoss-takes-complexity-out-of-configuration/)

**Nagios:** used to monitor servers and services, once configured, it is reliable, powerful, but cost of complexity

**Zenoss:** uses SNMP to "auto-configure" hosts, so having it readily available on the hosts you want to monitor will ease configuration quite a bit.

**SNMP:** Simple Network Management Protocol

“Internet-standard protocol” for managing devices on IP networks.

used mostly in network management systems to monitor network-attached devices for conditions that warrant administrative attention.

[SNMP](http://en.wikipedia.org/wiki/Simple_Network_Management_Protocol)

**1)Name some resources that you might monitor for a production host:**
routers

switches

servers

firewalls

applications

devices

**2)There's a big problem with most monitoring: a momentary spike in resource usage isn't actually a problem. Some software, like the 'god' gem, tries to overcome this limitation. Can you think of some strategies to solve this problem?**

### 13. Web Proxies

[common types of proxies](https://medium.com/@jmmastey/proxies-and-you-2846c5fc0c7b)

**request a page:**
our browser will silently ask a DNS server to resolve that domain name into an IP address. We’ll then send a request to that IP address with our requested page

**One machine, one IP, one web server.**

**nginx proxy:** another webserver in front of pumas to distribute requests.

**load_balancer:** a node level, will accept all incoming traffic and send it to one of our web nodes.

**Proxy server:** is a server(a computer system or an application) that acts as an intermediary for requests from clients seeking resources from other servers.

A client connects to the proxy server, requesting some service(file, connection, web page), the proxy server evaluates the request as a way to simplify and control its complexity.

1)
![image](http://www.linuxjournal.com/files/linuxjournal.com/linuxjournal/articles/104/10407/10407f1.jpg)

**2) web proxy pros:**

evalutes the request as a way to simply and control  its complexity.

to add structure and encapsulation to distributed systems.

facilitate access to content on the www. and providing anonymity.

**3) uses of proxy servers:**

Monitoring and filtering

Filtering of encrypted data

Bypassing filters and censorship

Improving performance

Accessing services anonymously

Security


### 14. Managing Server Time (NTP)

[ntpdate](http://linux.die.net/man/8/ntpdate)

**ntpdate:** set the date and time via NTP(Network Time Protocol)

Set the local date and time by polling the NTP servers given as the server arguments to determine the correct time. 

It must be run as root on the local host.

### 15, 16 Firewalls, iptables, and nmap

[IPTables](http://www.tecmint.com/basic-guide-on-iptables-linux-firewall-tips-commands/)


**Firewalls:** decides fate of packets incoming and outgoing in system. 

**IPTables:** a rule based firewall, a front-end tool to talk to the kernel and decides the packets to filter.

**IPTables applies to IPv4**

**IPTables main files:**

* /etc/init.d/iptables - init script to start|stop|restart and save rulesets
* /etc/sysconfig/iptables - where Rulesets are saved
* /sbin/iptables - binary

**start,stop,restart Iptable Firewall:**

* /etc/init.d/iptables start 
* /etc/init.d/iptables stop
* /etc/init.d/iptables restart

**[15:43:54]cnuapp@local:~$ whereis iptables**

iptables: /sbin/iptables /usr/share/iptables /usr/share/man/man8/iptables.8.gz

**start IPTables on system boot:**

chkconfig --level 345 iptables on

**save IPTables rulesets:**

service iptables save

**check the status of IPTables / Firewall:**

iptables -L -n -v

[Nmap](https://www.digitalocean.com/community/tutorials/how-to-use-nmap-to-scan-for-open-ports-on-your-vps)

scan the machine and display a report of all ports that are open and listening

























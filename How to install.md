# Installation instruction

FreeSWITCH™ can be installed from packages as follows
~~~
yum install -y http://files.freeswitch.org/freeswitch-release-1-6.noarch.rpm epel-release
yum install -y freeswitch-config-vanilla freeswitch-lang-* freeswitch-sounds-*
systemctl enable freeswitch
~~~

FreeSWITCH™ is now installed and can be accessed with

## FreeSwitch CLI

~~~
fs_cli -rRS
~~~

Upload rpms with FreeSwitch 1.8.5 from the RPM directory and update FreeSwitch installation using yum

~~~
yum install -y *.rpm
~~~

More details regarding FreeSwitch installation and how to build rpm packages from sources is here: https://freeswitch.org/confluence/display/FREESWITCH/CentOS+7+and+RHEL+7



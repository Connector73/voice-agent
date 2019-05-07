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

## UniMRCP installation

This topic describes how to obtain and install UniMRCP binary packages on Red Hat-based Linux distributions. The document is intended for system administrators and developers.

### Applicable Versions

Instructions provided in this guide are applicable to the following versions.
 
UniMRCP 1.4.0 and above

### Authentication

UniMRCP binary packages are available to authenticated users only. In order to register a free account with UniMRCP, please visit the following page.
 
https://www.unimrcp.org/profile-registration

Note: a new account needs to be verified and activated prior further proceeding.
 
### Installing RPMs Using YUM

Using the Yellowdog Updater, Modifier (yum), a command-line package management utility for Red Hat-based distributions, is recommended for installation of UniMRCP binary packages.

### Repository Configuration

The content of a typical yum configuration file, to be placed in /etc/yum.repos.d/unimrcp.repo, is provided below.
 
~~~
[unimrcp]

name=UniMRCP Packages for Red Hat / Cent OS-$releasever $basearch

baseurl=https://username:password@unimrcp.org/repo/yum/main/rhel$releasever/$basearch/

enabled=1

sslverify=1

gpgcheck=1

gpgkey=https://unimrcp.org/keys/unimrcp-gpg-key.public
~~~
 
The username and password fields included in the HTTPS URI must be replaced with the corresponding account credentials.

### Repository Verification

In order to verify that yum can properly connect and access the UniMRCP repository, the following command can be used.

~~~
yum repolist unimrcp
~~~
 
where unimrcp is a name of the section set in the yum configuration file above.
 
In order to retrieve a list of packages the UniMRCP repository provides, the following command can be used.

~~~ 
yum --disablerepo="*" --enablerepo="unimrcp" list available
~~~

### UniMRCP Client Installation

In order to install the UniMRCP client binaries, including the dependencies, the following command can be used.

~~~
yum install unimrcp-client
~~~
 
As a result, yum will check and prompt to download all the required packages by installing them in the directory /opt/unimrcp. Similarly, for installation of development kit(s), the UniMRCP client libraries and header files, the following command may follow.

~~~
yum install unimrcp-client-devel
~~~
 
### UniMRCP Server Installation

In order to install the UniMRCP server binaries, including the dependencies, the following command can be used.

~~~
yum install unimrcp-server
~~~
 
As a result, yum will check and prompt to download all the required packages by installing them in the directory /opt/unimrcp. Similarly, for installation of development kit(s), the UniMRCP server libraries and header files, the following command may follow.

~~~
yum install unimrcp-server-devel
~~~
 
In order to install a package containing a set of demo plugins to the UniMRCP server, the following command can be used.

~~~ 
yum install unimrcp-demo-plugins
~~~

## ASW Polly speech synthesis plugin installation

This guide describes how to obtain and install binary packages for the Amazon Web Services (AWS) Polly speech synthesis plugin to the UniMRCP server on Red Hat-based Linux distributions. The document is intended for system administrators and developers.

### Applicable Versions

Instructions provided in this guide are applicable to the following versions.
 
UniMRCP 1.5.0 and above

UniMRCP Polly Plugin 1.0.0 and above

### Authentication

UniMRCP binary packages are available to authenticated users only. In order to register a free account with UniMRCP, please visit the following page.


https://www.unimrcp.org/profile-registration

 
Note: a new account needs to be verified and activated prior further proceeding.
 
### Installing RPMs Using YUM

Using the Yellowdog Updater, Modifier (yum), a command-line package management utility for Red Hat-based distributions, is recommended for installation of UniMRCP binary packages.

### Repository Configuration

The content of a typical yum configuration file, to be placed in /etc/yum.repos.d/unimrcp.repo, is provided below.

~~~ 
[unimrcp]

name=UniMRCP Packages for Red Hat / Cent OS-$releasever $basearch

baseurl=https://username:password@unimrcp.org/repo/yum/main/rhel$releasever/$basearch/

enabled=1

sslverify=1

gpgcheck=1

gpgkey=https://unimrcp.org/keys/unimrcp-gpg-key.public

 

[unimrcp-noarch]

name=UniMRCP Packages for Red Hat / Cent OS-$releasever noarch

baseurl=https://username:password@unimrcp.org/repo/yum/main/rhel$releasever/noarch/

enabled=1

sslverify=1

gpgcheck=1

gpgkey=https://unimrcp.org/keys/unimrcp-gpg-key.public
~~~
 
The username and password fields included in the HTTPS URI must be replaced with the corresponding account credentials.

### Repository Verification

In order to verify that yum can properly connect and access the UniMRCP repository, the following command can be used.

~~~
yum repolist unimrcp

yum repolist unimrcp-noarch
~~~
 
where unimrcp and unimrcp-noarch are names of the sections set in the yum configuration file above.
 
In order to retrieve a list of packages the UniMRCP repository provides, the following command can be used.

~~~
yum --disablerepo="*" --enablerepo="unimrcp" list available

yum --disablerepo="*" --enablerepo="unimrcp-noarch" list available
~~~
 
### Polly Plugin Installation

In order to install the Polly plugin, including all the dependencies, use the following command.

~~~ 
yum install unimrcp-polly
~~~
 
In order to install the additional data files for the sample client application umc, the following command can be used.

~~~ 
yum install umc-addons
~~~
 
Note: this package is optional and provides additional data which can be used for validation of basic setup.

### Obtaining License

The Polly plugin to the UniMRCP server is a commercial product, which requires a license file to be installed.


### Node Information

The license files are bound to a node the product is installed on. In order to obtain a license, the corresponding node information needs to be retrieved and submitted for generation of a license file.
 
Use the installed tool unilicnodegen to retrieve the node information.
 
~~~
/opt/unimrcp/bin/unilicnodegen
~~~
 
As a result, a text file uninode.info will be saved in the current directory. Submit the file uninode.info for license generation to services@unimrcp.org by mentioning the product name in the subject.

### License Installation

The license file needs to be placed into the directory /opt/unimrcp/data.

~~~ 
cp umspolly_*.lic /opt/unimrcp/data
~~~

### Obtaining Service Credentials

In order to utilize the AWS Polly API, corresponding service credentials need to be retrieved from the AWS console and further installed to the UniMRCP server.

### Create IAM User

Sign up for an AWS account and create an IAM user.
 
https://docs.aws.amazon.com/polly/latest/dg/setting-up.html

### Installation of Credentials

Create a text file aws.credentials in the directory /opt/unimrcp/data.

~~~ 
nano /opt/unimrcp/data/aws.credentials
~~~
 
Place your AWS IAM user credentials in the following format.

~~~ 
{

  "aws_access_key_id": "••••••••••••",

  "aws_secret_access_key": "••••••••••••••••••••••••••••••••••••"

}
~~~
 
### Configuring Server and Plugin

#### Plugin Factory Configuration

In order to load the Polly plugin into the UniMRCP server, open the file unimrcpserver.xml, located in the directory /opt/unimrcp/conf, and add the following entry under the XML element <plugin-factory>. Disable other synthesis plugins, if available. The remaining demo plugins might also be disabled, if not installed.

~~~
  <!-- Factory of plugins (MRCP engines) -->

  <plugin-factory>

      <engine id="Demo-Synth-1" name="demosynth" enable="false"/>

      <engine id="Demo-Recog-1" name="demorecog" enable="true"/>

      <engine id="Demo-Verifier-1" name="demoverifier" enable="true"/>

      <engine id="Recorder-1" name="mrcprecorder" enable="true"/>

      <engine id="Polly-1" name="umspolly" enable="true"/>

  </plugin-factory>
~~~
 
#### Logger Configuration

In order to enable log output from the plugin and set filtering rules, open the configuration file logger.xml, located in the directory /opt/unimrcp/conf, and add the following entry under the element <sources>.

~~~
    <source name="POLLY-PLUGIN" priority="INFO" masking="NONE"/>
~~~
 
#### Polly Plugin Configuration

The configuration file of the plugin is located in /opt/unimrcp/conf/umspolly.xml. Default settings should be sufficient for general use.
 
Refer to the Usage Guide for more information.
 
### Validating Setup

Validate your setup by using the sample UniMRCP client and server applications on the same host. The default configuration and data files should be sufficient for a basic test.

#### Launching Server

Launch the UniMRCP server application.

~~~
cd /opt/unimrcp/bin
./unimrcpserver
~~~
 
In the server log output, check whether the plugin is normally loaded.

~~~ 
[INFO]   Load Plugin [Polly-1] [/opt/unimrcp/plugin/umspolly.so]
~~~
 
Next, check for the license information.

~~~ 
[NOTICE] UniMRCP Polly License

-product name:    umspolly

-product version: 1.0.0

-license owner:  -

-license type:    trial

-issue date:      2018-08-22

-exp date:        2018-09-21

-channel count:   2

-feature set:     0
~~~
 
Next, check that the service account credentials are normally populated.
 
~~~ 
[NOTICE] Read AWS Credentials /opt/unimrcp/data/aws.credentials
~~~
 
####  Launching Client

Note: the optional package umc-addons must be installed for this test to work.
 
Launch the sample UniMRCP client application umc.
 
~~~ 
cd /opt/unimrcp/bin
./umc
~~~
 
Run a typical speech synthesis scenario by issuing the command run bss1 from the console of the umc client application.

~~~ 
run bss1
~~~
 
This command sends a SPEAK request to the server and then records synthesized stream into a PCM file stored in the directory /opt/unimrcp/var.
 
Visually inspect the log output for any possible warnings or errors.

## AWS Lex speech recognition plugin installation

This guide describes how to obtain and install binary packages for the Amazon Web Services (AWS) Lex plugin to the UniMRCP server on Red Hat-based Linux distributions. The document is intended for system administrators and developers.

### Authentication

UniMRCP binary packages are available to authenticated users only. In order to register a free account with UniMRCP, please visit the following page.
 
https://www.unimrcp.org/profile-registration

 
Note: a new account needs to be verified and activated prior further proceeding.
 
### Installing RPMs Using YUM

Using the Yellowdog Updater, Modifier (yum), a command-line package management utility for Red Hat-based distributions, is recommended for installation of UniMRCP binary packages.

### Repository Configuration

The content of a typical yum configuration file, to be placed in /etc/yum.repos.d/unimrcp.repo, is provided below.

~~~
[unimrcp]

name=UniMRCP Packages for Red Hat / Cent OS-$releasever $basearch

baseurl=https://username:password@unimrcp.org/repo/yum/main/rhel$releasever/$basearch/

enabled=1

sslverify=1

gpgcheck=1

gpgkey=https://unimrcp.org/keys/unimrcp-gpg-key.public

 

[unimrcp-noarch]

name=UniMRCP Packages for Red Hat / Cent OS-$releasever noarch

baseurl=https://username:password@unimrcp.org/repo/yum/main/rhel$releasever/noarch/

enabled=1

sslverify=1

gpgcheck=1

gpgkey=https://unimrcp.org/keys/unimrcp-gpg-key.public
~~~
 
The username and password fields included in the HTTPS URI must be replaced with the corresponding account credentials.

### Repository Verification

In order to verify that yum can properly connect and access the UniMRCP repository, the following command can be used.
 
~~~
yum repolist unimrcp

yum repolist unimrcp-noarch
~~~
 
where unimrcp and unimrcp-noarch are names of the sections set in the yum configuration file above.
 
In order to retrieve a list of packages the UniMRCP repository provides, the following command can be used.

~~~ 
yum --disablerepo="*" --enablerepo="unimrcp" list available

yum --disablerepo="*" --enablerepo="unimrcp-noarch" list available
~~~
 
### Lex Plugin Installation

In order to install the Lex plugin, including all the dependencies, use the following command.

~~~ 
yum install unimrcp-lex
~~~
 
In order to install the additional data files for the sample client application umc, the following command can be used.
 
~~~ 
yum install umc-addons
~~~
 
Note: this package is optional and provides additional data which can be used for validation of basic setup.

### Obtaining License

The Lex plugin to the UniMRCP server is a commercial product, which requires a license file to be installed.

### Node Information

The license files are bound to a node the product is installed on. In order to obtain a license, the corresponding node information needs to be retrieved and submitted for generation of a license file.
 
Use the installed tool unilicnodegen to retrieve the node information.

~~~ 
/opt/unimrcp/bin/unilicnodegen
~~~
 
As a result, a text file uninode.info will be saved in the current directory. Submit the file uninode.info for license generation to services@unimrcp.org by mentioning the product name in the subject.

### License Installation

The license file needs to be placed into the directory /opt/unimrcp/data.

~~~ 
cp umslex_*.lic /opt/unimrcp/data
~~~


### Obtaining Service Credentials

In order to utilize the AWS Lex API, corresponding service credentials need to be retrieved from the AWS console and further installed to the UniMRCP server.

#### Create IAM User

Sign up for an AWS account and create an IAM user.
 
https://docs.aws.amazon.com/lex/latest/dg/gs-account.html
 
#### Installation of Credentials

Create a text file aws.credentials in the directory /opt/unimrcp/data.

~~~ 
nano /opt/unimrcp/data/aws.credentials
~~~
 
Place your AWS IAM user credentials in the following format.

~~~ 
{

  "aws_access_key_id": "••••••••••••",

  "aws_secret_access_key": "••••••••••••••••••••••••••••••••••••"

}
~~~
 
### Configuring Server and Plugin

#### Plugin Factory Configuration

In order to load the Lex plugin into the UniMRCP server, open the file unimrcpserver.xml, located in the directory /opt/unimrcp/conf, and add the following entry under the XML element <plugin-factory>. Disable other synthesis plugins, if available. The remaining demo plugins might also be disabled, if not installed.

~~~
  <!-- Factory of plugins (MRCP engines) -->

  <plugin-factory>

      <engine id="Demo-Synth-1" name="demosynth" enable="false"/>

      <engine id="Demo-Recog-1" name="demorecog" enable="true"/>

      <engine id="Demo-Verifier-1" name="demoverifier" enable="true"/>

      <engine id="Recorder-1" name="mrcprecorder" enable="true"/>

      <engine id="Lex-1" name="umslex" enable="true"/>

  </plugin-factory>
~~~
 
#### Logger Configuration

In order to enable log output from the plugin and set filtering rules, open the configuration file logger.xml, located in the directory /opt/unimrcp/conf, and add the following entry under the element <sources>.

~~~ 
    <source name="LEX-PLUGIN" priority="INFO" masking="NONE"/>
~~~
 
#### Lex Plugin Configuration

The configuration file of the plugin is located in /opt/unimrcp/conf/umslex.xml. Default settings should be sufficient for general use.
 
Refer to the Usage Guide for more information.
 
### Validating Setup

Validate your setup by using the sample UniMRCP client and server applications on the same host. The default configuration and data files should be sufficient for a basic test.

#### Setting up Sample Lex Bot

Follow the instructions (https://docs.aws.amazon.com/lex/latest/dg/ex-book-trip-create-bot.html) to create a sample BookTrip Lex bot.
 
In order to identify the created Lex bot, the corresponding parameters must be specified in the configuration file of the plugin, located in /opt/unimrcp/conf/umslex.xml.
 
~~~

   <streaming-recognition

      language="en-US"

      region="us-west-2"

      bot-name="BookTrip"

      alias="Dev"

   />
~~~
 
#### Launching Server

Launch the UniMRCP server application.

~~~ 
cd /opt/unimrcp/bin
./unimrcpserver
~~~
 
In the server log output, check whether the plugin is normally loaded.
 
~~~ 
[INFO]   Load Plugin [Lex-1] [/opt/unimrcp/plugin/umslex.so]
~~~
 
Next, check for the license information.

~~~ 
[NOTICE] UniMRCP Lex License

 

-product name:    umslex

-product version: 1.0.0

-license owner:  -

-license type:    trial

-issue date:      2018-09-15

-exp date:        2018-10-15

-channel count:   2

-feature set:     0
~~~
 
Next, check that the service account credentials are normally populated.

~~~ 
[NOTICE] Read AWS Credentials /opt/unimrcp/data/aws.credentials
~~~
 
#### Launching Client

Note: the optional package umc-addons must be installed for this test to work.
 
Launch the sample UniMRCP client application umc.

~~~ 
cd /opt/unimrcp/bin
./umc
~~~
 
Run a typical speech synthesis scenario by issuing the command run lex1 from the console of the umc client application.

~~~ 
run lex1
~~~
 
This command sends a RECOGNIZE request to the server and then starts streaming a sample audio input file bookroom.pcm to recognize.
 
Check for the NLSML results to be returned as expected.

~~~ 
<?xml version="1.0"?>

<result>

  <interpretation grammar="builtin:speech/transcribe" confidence="1">

    <instance>

      <intent>BookHotel</intent>

      <slots>

        <CheckInDate></CheckInDate>

        <Location></Location>

        <Nights></Nights>

        <RoomType></RoomType>

      </slots>

      <message>What city will you be staying in?</message>

      <dialogstate>ElicitSlot</dialogstate>

      <slottoelicit>Location</slottoelicit>

    </instance>

    <input mode="speech">book a room</input>

  </interpretation>

</result>
~~~
 
Visually inspect the log output for any possible warnings or errors.
 
Note that utterances are stored in the var directory, if the corresponding parameter is enabled in the configuration file umslex.xml and/or requested by the client.

## Configuring Unimrcp to support BOTS

Full Unimrcp server configuration located in unimrcp/conf. You can use it to update the configuration on the server.
 
## Configuring FreeSwitch

Full FreeSWITCH configuration is located in freeswitch directory. You can use it to update the configuration on the server.

### Manually Update

#### Add Zultuys MXvirtual or any other Voip PBX as a gateway

Create config file /etc/freeswitch/sip_profiles/external/example.xml:

~~~
<include>
  <gateway name="mxvirtual">
    <param name="username" value="test"/>
    <param name="password" value="1234"/>
    <param name="proxy" value="52.169.137.203"/>
    <param name="caller-id-in-from" value="true"/> <!--Most gateways seem to want this-->
    <param name="register" value="false"/>
    <param name="context" value="public"/>
    <param name="from-domain" value="52.169.137.203"/>
  </gateway>
</include>
~~~

Address 52.169.137.203 must be replaced with IP address of your voip PBX (SIP server).

#### External number and test speech syntesizer

Cereate config file /etc/freeswitch/dialplan/public/mx_porivder.xml:

~~~
<extension name="mxvirtual">
 <condition field="destination_number" expression="^3728803046">
   <action application="answer"/>
   <action application="sleep" data="500"/>
   <action application="set" data="tts_engine=unimrcp:uni2"/>
   <action application="set" data="tts_voice=Salli"/>
   <action application="speak" data="This is Polly, I am so busy now. Please call me back later. Have a good day"/>
   <action application="sleep" data="2000"/>
 </condition>
</extension>
~~~

External phone number is 3728803046.
You are ready to make the test call.

Add following text to enable redirection for calls from FreeSWITCH (BOTs) to internal extension on the voip PBX.

~~~
<extension name="mxvirtual_int">
 <condition field="destination_number" expression="^9(1\d{2})$">
   <action application="bridge" data="sofia/gateway/mxvirtual/$1"/>
 </condition>
</extension>
~~~

Replace configuration for mxvirtual to run the BOT script on incomming call.

~~~
<extension name="mxvirtual">
 <condition field="destination_number" expression="^3728803046">
   <action application="answer"/>
   <action application="set" data="tts_engine=unimrcp:uni2"/>
   <action application="set" data="tts_voice=Salli"/>
   <!-- action application="javascript" data="lex.js"/ -->
   <action application="lua" data="lex.lua"/>
 </condition>
</extension>
~~~

### Upload scripts to the server

Simple Lex BOT configuration is located in LexBot directory. It can be imported to AWS. More details is here: https://docs.aws.amazon.com/lex/latest/dg/import-from-lex.html


Basic scripts are located in scripts. Scripts must be uploaded to /usr/share/freeswitch/scripts on the server.
xmlSimple.lua is simple XML parser to parse Lex responses
lex.lua is simple BOT script to working with Lex engine.

### Test configured server

[TBD]

## What next?

Modify lex.lua to support store results in the external databases.
Short example:

~~~
local dbh = freeswitch.Dbh("odbc://my_db:uname:passwd") -- connect to ODBC database 
 
assert(dbh:connected()) -- exits the script if we didn't connect properly
 
dbh:test_reactive("SELECT * FROM my_table",
                  "DROP TABLE my_table",
                  "CREATE TABLE my_table (id INTEGER(8), name VARCHAR(255))")
 
dbh:query("INSERT INTO my_table VALUES(1, 'foo')") -- populate the table
dbh:query("INSERT INTO my_table VALUES(2, 'bar')") -- with some test data
 
dbh:query("SELECT id, name FROM my_table", function(row)
  stream:write(string.format("%5s : %s\n", row.id, row.name))
end)
 
dbh:query("UPDATE my_table SET name = 'changed'")
stream:write("Affected rows: " .. dbh:affected_rows() .. "\n")
 
dbh:release() -- optional
~~~

More details is here: https://freeswitch.org/confluence/display/FREESWITCH/Lua+with+Database

# Well done!


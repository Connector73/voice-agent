# AWS Lex Plugin

This guide describes how to configure and use the Amazon Web Services (AWS) Lex plugin to the UniMRCP server. The document is intended for users having a certain knowledge of AWS Lex and UniMRCP.
Asterisk / FreeSWITCH
 
## Supported Features

This is a brief check list of the features currently supported by the UniMRCP server running with the Lex
 plugin.

### MRCP Methods

 DEFINE-GRAMMAR

 RECOGNIZE

 START-INPUT-TIMERS

 STOP

 SET-PARAMS

 GET-PARAMS

###  MRCP Events

 RECOGNITION-COMPLETE

 START-OF-INPUT

### MRCP Header Fields

 Input-Type

 No-Input-Timeout

 Recognition-Timeout

 Speech-Complete-Timeout

 Waveform-URI

 Media-Type

 Completion-Cause

 Confidence-Threshold

 Start-Input-Timers

 DTMF-Interdigit-Timeout

 DTMF-Term-Timeout

 DTMF-Term-Char

 Save-Waveform

 Speech-Language

 Cancel-If-Queue

 Sensitivity-Level

### Grammars

 Built-in speech, event and DTMF grammars

 SRGS XML (limited support)

### Results

 NLSML

 JSON

 
## Configuration Format

The configuration file of the Lex plugin is located in /opt/unimrcp/conf/umslex.xml. The configuration file is written in XML.

 
## Configuration Steps

This section outlines common configuration steps.
###      Using Default Configuration

The default configuration should be sufficient for the general use.
###      Using with Polly

This section must be skipped if the Lex plugin is used without the Polly plugin. However, in case both Polly and Lex plugins are loaded into the same instance of UniMRCP server, then the plugins need to be configured in a certain way to ensure the AWS SDK is initialized and shutdown only once.

~~~ 
<umspolly license-file="umspolly_*.lic" credentials-file="aws.credentials" init-sdk="true" shutdown-sdk="false">

<umslex license-file="umslex_*.lic" credentials-file="aws.credentials" init-sdk="false" shutdown-sdk="true">
~~~
 
###      Specifying Lex Bot

The parameters of the Lex bot region, bot-name and alias must be specified in the configuration file umslex.xml. For example:

~~~ 
   <streaming-recognition

      language="en-US"

      region="us-west-2"

      bot-name="BookTrip"

      alias="Dev"

   />
~~~
 
The parameters bot-name and alias can also be specified per individual MRCP SET-PARAMS or RECOGNIZE requests via the header field Vendor-Specific-Parameters.
~~~ 
Vendor-Specific-Parameters: bot-name=BookTrip; alias=Dev
~~~
 
###      Specifying Recognition Language

Recognition language can be specified by the client per MRCP session by means of the header field Speech-Language set in a SET-PARAMS or RECOGNIZE request. Otherwise, the parameter language set in the configuration file umslex.xml is used. The parameter defaults to en-US.
###      Specifying Sampling Rate

Sampling rate is determined based on the SDP negotiation. Refer to the configuration guide of the UniMRCP server on how to specify supported encodings and sampling rates to be used in communication between the client and server.
The native sampling rate with the linear16 audio encoding is used to post audio data to the Lex service.
###      Specifying Speech Input Parameters

While the default parameters specified for the speech input detector are sufficient for the general use, various parameters can be adjusted to better suit a particular requirement.

·         speech-start-timeout

This parameter is used to trigger a start of speech input. The shorter is the timeout, the sooner a START-OF-INPUT event is delivered to the client. However, a short timeout may also lead to a false positive.
·         speech-complete-timeout

This parameter is used to trigger an end of speech input. The shorter is the timeout, the shorter is the response time. However, a short timeout may also lead to a false positive.
·         vad-mode

This parameter is used to specify an operating mode of the Voice Activity Detector (VAD) within an integer range of [0 … 3]. A higher mode is more aggressive and, as a result, is more restrictive in reporting speech. The parameter can be overridden per MRCP session by setting the header field Sensitivity-Level in a SET-PARAMS or RECOGNIZE request. The following table shows how the Sensitivity-Level is mapped to the vad-mode.
 
Sensitivity-Level
Vad-Mode
[0.00 ... 0.25)
0
[0.25 … 0.50)
1
[0.50 ... 0.75)
2
[0.75 ... 1.00]
3
 
###      Specifying DTMF Input Parameters

While the default parameters specified for the DTMF input detector are sufficient for the general use, various parameters can be adjusted to better suit a particular requirement.

·         dtmf-interdigit-timeout

This parameter is used to set an inter-digit timeout on DTMF input. The parameter can be overridden per MRCP session by setting the header field DTMF-Interdigit-Timeout in a SET-PARAMS or RECOGNIZE request.
·         dtmf-term-timeout

This parameter is used to set a termination timeout on DTMF input and is in effect when dtmf-term-char is set and there is a match for an input grammar. The parameter can be overridden per MRCP session by setting the header field DTMF-Term-Timeout in a SET-PARAMS or RECOGNIZE request.

·         dtmf-term-char

This parameter is used to set a character terminating DTMF input. The parameter can be overridden per MRCP session by setting the header field DTMF-Term-Char in a SET-PARAMS or RECOGNIZE request.

###      Specifying No-Input and Recognition Timeouts

·         noinput-timeout

This parameter is used to trigger a no-input event. The parameter can be overridden per MRCP session by setting the header field No-Input-Timeout in a SET-PARAMS or RECOGNIZE request.

·         input-timeout

This parameter is used to limit input (recognition) time. The parameter can be overridden per MRCP session by setting the header field Recognition-Timeout in a SET-PARAMS or RECOGNIZE request.

###      Maintaining Utterances

Saving of utterances is not required for regular operation and is disabled by default. However, enabling this functionality allows to save utterances sent to the Lex service and later listen to them offline.

The relevant settings can be specified via the element utterance-manager.

·         save-waveforms

Utterances can optionally be recorded and stored if the configuration parameter save-waveforms is set to true. The parameter can be overridden per MRCP session by setting the header field Save-Waveforms in a SET-PARAMS or RECOGNIZE request.
·         purge-existing

This parameter specifies whether to delete existing waveforms on start-up.
·         max-file-age

This parameter specifies a time interval in minutes after expiration of which a waveform is deleted. If set to 0, there is no expiration time specified.
·         max-file-count

This parameter specifies the maximum number of waveforms to store. If the specified number is reached, the oldest waveform is deleted. If set to 0, there is no limit specified.
·         waveform-base-uri

This parameter specifies the base URI used to compose an absolute waveform URI returned in the header field Waveform-Uri in response to a RECOGNIZE request.

·         waveform-folder

This parameter specifies a path to the directory used to store waveforms in. The directory defaults to ${UniMRCPInstallDir}/var.

###  Maintaining Recognition Details Records

Producing of recognition details records (RDR) is not required for regular operation and is disabled by default. However, enabling this functionality allows to store details of each recognition attempt in a separate file and analyze them later offline. The RDRs ate stored in the JSON format.

The relevant settings can be specified via the element rdr-manager.

·         save-records

This parameter specifies whether to save recognition details records or not.
·         purge-existing

This parameter specifies whether to delete existing records on start-up.
·         max-file-age

This parameter specifies a time interval in minutes after expiration of which a record is deleted. If set to 0, there is no expiration time specified.
·         max-file-count

This parameter specifies the maximum number of records to store. If the specified number is reached, the oldest record is deleted. If set to 0, there is no limit specified.
·         record-folder

This parameter specifies a path to the directory used to store records in. The directory defaults to ${UniMRCPInstallDir}/var.

##       Recognition Grammars and Results

###      Using Built-in Speech Grammar

A pre-set built-in speech grammar can be referenced by the MRCP client in a RECOGNIZE request as follows:

~~~
builtin:speech/transcribe
~~~
 
###      Using Built-in DTMF Grammars

Pre-set built-in DTMF grammars can be referenced by the MRCP client in a RECOGNIZE request as follows:
 
~~~ 
builtin:dtmf/$id
~~~
 
As a result, captured DTMFs will be posted to the Lex service for intent detection.
###      Retrieving Results

Results received from the Lex service are transformed to one of the following formats
·         NLSML

·         JSON

and sent to the MRCP client in a RECOGNITION-COMPLETE event. Recognition results settings can be specified in the configuration file in the element results.
 
In case of NLSML results, the <instance> element contains an XML representation of the results received from the Lex service.
##       Monitoring Usage Details

The number of in-use and total licensed channels can be monitored in several alternate ways. There is a set of actions which can take place on certain events. The behavior is configurable via the element monitoring-agent, which contains two event handlers: usage-change-handler and usage-refresh-handler.
 
While the usage-change-handler is invoked on every acquisition and release of a licensed channel, the usage-refresh-handler is invoked periodically on expiration of a timeout specified by the attribute refresh-period.
 
The following actions can be specified for either of the two handlers.
##      Log Usage

The action log-usage logs the following data in the order specified.
·         The number of currently in-use channels.

·         The maximum number of channels used concurrently.

·         The total number of licensed channels.

The following is a sample log statement, indicating 0 in-use, 0 max-used and 2 total channels.
 
[NOTICE] Lex Usage: 0/0/2

 
##      Update Usage

The action update-usage writes the following data to a status file umslex-usage.status, located by default in the directory ${UniMRCPInstallDir}/var/status.
·         The number of currently in-use channels.

·         The maximum number of channels used concurrently.

·         The total number of licensed channels.

·         The current status of the license permit.

·         The license server alarm. Set to on, if the license server is not available for more than one hour; otherwise, set to off. This parameter is maintained only if the license server is used. Available since 1.2.0.

The following is a sample content of the status file.
 
in-use channels: 0

max used channels: 0

total channels: 2

license permit: true

licserver alarm: off

 
##      Dump Channels

The action dump-channels writes the identifiers of in-use channels to a status file umslex-channels.status, located by default in the directory ${UniMRCPInstallDir}/var/status.
 
##      Usage Examples

###      Hotel Booking

This example demonstrates an MRCP message exchange based on a conversation with the sample BookTrip Lex bot.
Interaction 1
 
Input: Book a hotel

~~~ 
C->S:
 
MRCP/2.0 361 RECOGNIZE 1

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Content-Id: request1@form-level

Content-Type: text/uri-list

Cancel-If-Queue: false

No-Input-Timeout: 50000

Recognition-Timeout: 10000

Start-Input-Timers: true

Confidence-Threshold: 0.87

Sensitivity-Level: 0.5

Save-Waveform: true

Content-Length: 25

 

builtin:speech/transcribe

 
S->C:
 
MRCP/2.0 83 1 200 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

 

 
S->C:
 
MRCP/2.0 115 START-OF-INPUT 1 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Input-Type: speech

 

 
S->C:
 
MRCP/2.0 823 RECOGNITION-COMPLETE 1 COMPLETE

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Completion-Cause: 000 success

Waveform-Uri: <http://localhost/utterances/umslex-2a203b9adebe40e7-1.wav>;size=21440;duration=1340

Content-Type: application/x-nlsml

Content-Length: 538

 

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

    <input mode="speech">book a hotel</input>

  </interpretation>

</result>
~~~
 
Interaction 2
 
Input: Sunnyvale
~~~ 
C->S:
 
MRCP/2.0 361 RECOGNIZE 2

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Content-Id: request1@form-level

Content-Type: text/uri-list

Cancel-If-Queue: false

No-Input-Timeout: 50000

Recognition-Timeout: 10000

Start-Input-Timers: true

Confidence-Threshold: 0.87

Sensitivity-Level: 0.5

Save-Waveform: true

Content-Length: 25

 

builtin:speech/transcribe

 
S->C:
 
MRCP/2.0 83 2 200 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

 

 
S->C:
 
MRCP/2.0 115 START-OF-INPUT 2 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Input-Type: speech

 

 
S->C:
 
MRCP/2.0 832 RECOGNITION-COMPLETE 2 COMPLETE

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Completion-Cause: 000 success

Waveform-Uri: <http://localhost/utterances/umslex-2a203b9adebe40e7-2.wav>;size=18400;duration=1150

Content-Type: application/x-nlsml

Content-Length: 547

 

<?xml version="1.0"?>

<result>

  <interpretation grammar="builtin:speech/transcribe" confidence="1">

    <instance>

      <intent>BookHotel</intent>

      <slots>

        <CheckInDate></CheckInDate>

        <Location>sunnyvale</Location>

        <Nights></Nights>

        <RoomType></RoomType>

      </slots>

      <message>What day do you want to check in?</message>

      <dialogstate>ElicitSlot</dialogstate>

      <slottoelicit>CheckInDate</slottoelicit>

    </instance>

    <input mode="speech">sunnyvale</input>

  </interpretation>

</result>
~~~
 
Interaction 3
 
Input: October 1st
~~~ 
C->S:
 
MRCP/2.0 361 RECOGNIZE 3

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Content-Id: request1@form-level

Content-Type: text/uri-list

Cancel-If-Queue: false

No-Input-Timeout: 50000

Recognition-Timeout: 10000

Start-Input-Timers: true

Confidence-Threshold: 0.87

Sensitivity-Level: 0.5

Save-Waveform: true

Content-Length: 25

 

builtin:speech/transcribe

 
S->C:
 
MRCP/2.0 83 3 200 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

 

 
S->C:
 
MRCP/2.0 115 START-OF-INPUT 3 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Input-Type: speech

 

 
S->C:
 
MRCP/2.0 844 RECOGNITION-COMPLETE 3 COMPLETE

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Completion-Cause: 000 success

Waveform-Uri: <http://localhost/utterances/umslex-2a203b9adebe40e7-3.wav>;size=23520;duration=1470

Content-Type: application/x-nlsml

Content-Length: 559

 

<?xml version="1.0"?>

<result>

  <interpretation grammar="builtin:speech/transcribe" confidence="1">

    <instance>

      <intent>BookHotel</intent>

      <slots>

        <CheckInDate>2018-10-01</CheckInDate>

        <Location>sunnyvale</Location>

        <Nights></Nights>

        <RoomType></RoomType>

      </slots>

      <message>How many nights will you be staying?</message>

      <dialogstate>ElicitSlot</dialogstate>

      <slottoelicit>Nights</slottoelicit>

    </instance>

    <input mode="speech">october first</input>

  </interpretation>

</result>
~~~
 
Interaction 4
 
Input: 2 [nights]
~~~ 
C->S:
 
MRCP/2.0 361 RECOGNIZE 4

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Content-Id: request1@form-level

Content-Type: text/uri-list

Cancel-If-Queue: false

No-Input-Timeout: 50000

Recognition-Timeout: 10000

Start-Input-Timers: true

Confidence-Threshold: 0.87

Sensitivity-Level: 0.5

Save-Waveform: true

Content-Length: 25

 

builtin:speech/transcribe

 
S->C:
 
MRCP/2.0 83 4 200 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

 

 
S->C:
 
MRCP/2.0 115 START-OF-INPUT 4 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Input-Type: speech

 

 
S->C:
 
MRCP/2.0 856 RECOGNITION-COMPLETE 4 COMPLETE

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Completion-Cause: 000 success

Waveform-Uri: <http://localhost/utterances/umslex-2a203b9adebe40e7-4.wav>;size=13760;duration=860

Content-Type: application/x-nlsml

Content-Length: 572

 

<?xml version="1.0"?>

<result>

  <interpretation grammar="builtin:speech/transcribe" confidence="1">

    <instance>

      <intent>BookHotel</intent>

      <slots>

        <CheckInDate>2018-10-01</CheckInDate>

        <Location>sunnyvale</Location>

        <Nights>2</Nights>

        <RoomType></RoomType>

      </slots>

      <message>What type of room would you like, queen, king or deluxe?</message>

      <dialogstate>ElicitSlot</dialogstate>

      <slottoelicit>RoomType</slottoelicit>

    </instance>

    <input mode="speech">two</input>

  </interpretation>

</result>
~~~
 
Interaction 5
 
Input: King
~~~ 
C->S:
 
MRCP/2.0 361 RECOGNIZE 5

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Content-Id: request1@form-level

Content-Type: text/uri-list

Cancel-If-Queue: false

No-Input-Timeout: 50000

Recognition-Timeout: 10000

Start-Input-Timers: true

Confidence-Threshold: 0.87

Sensitivity-Level: 0.5

Save-Waveform: true

Content-Length: 25

 

builtin:speech/transcribe

 
S->C:
 
MRCP/2.0 83 5 200 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

 

 
S->C:
 
MRCP/2.0 115 START-OF-INPUT 5 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Input-Type: speech

 

 
S->C:
 
MRCP/2.0 869 RECOGNITION-COMPLETE 5 COMPLETE

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Completion-Cause: 000 success

Waveform-Uri: <http://localhost/utterances/umslex-2a203b9adebe40e7-5.wav>;size=12960;duration=810

Content-Type: application/x-nlsml

Content-Length: 585

 

<?xml version="1.0"?>

<result>

  <interpretation grammar="builtin:speech/transcribe" confidence="1">

    <instance>

      <intent>BookHotel</intent>

      <slots>

        <CheckInDate>2018-10-01</CheckInDate>

        <Location>sunnyvale</Location>

        <Nights>2</Nights>

        <RoomType>king</RoomType>

      </slots>

      <message>Okay, I have you down for a 2 night stay in sunnyvale starting 2018-10-01.  Shall I book the reservation?</message>

      <dialogstate>ConfirmIntent</dialogstate>

    </instance>

    <input mode="speech">king</input>

  </interpretation>

</result>
~~~ 
 
Interaction 6
 
Input: Yes
~~~
C->S:
 
MRCP/2.0 361 RECOGNIZE 6

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Content-Id: request1@form-level

Content-Type: text/uri-list

Cancel-If-Queue: false

No-Input-Timeout: 50000

Recognition-Timeout: 10000

Start-Input-Timers: true

Confidence-Threshold: 0.87

Sensitivity-Level: 0.5

Save-Waveform: true

Content-Length: 25

 

builtin:speech/transcribe

 
S->C:
 
MRCP/2.0 83 6 200 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

 

 
S->C:
 
MRCP/2.0 115 START-OF-INPUT 6 IN-PROGRESS

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Input-Type: speech

 

 
S->C:
 
MRCP/2.0 743 RECOGNITION-COMPLETE 6 COMPLETE

Channel-Identifier: 2a203b9adebe40e7@speechrecog

Completion-Cause: 000 success

Waveform-Uri: <http://localhost/utterances/umslex-2a203b9adebe40e7-6.wav>;size=14880;duration=930

Content-Type: application/x-nlsml

Content-Length: 459

 

<?xml version="1.0"?>

<result>

  <interpretation grammar="builtin:speech/transcribe" confidence="1">

    <instance>

      <intent>BookHotel</intent>

      <slots>

        <CheckInDate>2018-10-01</CheckInDate>

        <Location>sunnyvale</Location>

        <Nights>2</Nights>

        <RoomType>king</RoomType>

      </slots>

      <dialogstate>ReadyForFulfillment</dialogstate>

    </instance>

    <input mode="speech">yes</input>

  </interpretation>

</result>
~~~

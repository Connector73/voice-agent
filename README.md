# voice-agent
Simple MRCP based voice agent with support for BOTs

##Basic architecture

[FreeSWITCH] <--> [ umrcpserver ] <--> [AWS Lex/Polly] <--> [ Lex bot ]

     ^
     |
[ Lua / Javascript ]

     ^
     |
[ BOT script ] <--> [ External db/web services ]


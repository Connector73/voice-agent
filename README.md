# voice-agent
Simple MRCP based voice agent with support for BOTs

## Basic architecture

[FreeSWITCH] <--> [ umrcpserver ] <--> [AWS Lex/Polly] <--> [ Lex Speech Language Understanding (SLU) system ]

     ^
     |
     v
[ Lua / Javascript engine ]

     ^
     |
     v
[ BOT script ] <--> [ External db/web services ]


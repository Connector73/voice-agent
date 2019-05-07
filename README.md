# Voice agent

Voice Agent is a platform for building intelligent phone and text services, such as an interactive menu, information and booking services and so on. The basis for this platform is FreeSWITCH, which provides the connection and data transfer to the BOT responsible for the operation logic. External systems for speech synthesis and recognition are connected through the UniMRCP server. The basic natural language processing components are Amazon Poly and Amazon Lex. The first is responsible for the synthesis of voice, the second for recognition.
Intellectual robots can be created based on the language of Lua or Javascript. Javascript is performed on a special version of the v8 engine in from Google.

Amazon Polly is a cloud service that converts text into lifelike speech. You can use Amazon Polly to develop applications that increase engagement and accessibility. Amazon Polly supports multiple languages and includes a variety of lifelike voices, so you can build speech-enabled applications that work in multiple locations and use the ideal voice for your customers. With Amazon Polly, you only pay for the text you synthesize. You can also cache and replay Amazon Polly’s generated speech at no additional cost.

Amazon Lex is an AWS service for building conversational interfaces for applications using voice and text. With Amazon Lex, the same conversational engine that powers Amazon Alexa is now available to any developer, enabling you to build sophisticated, natural language chatbots into your new and existing applications. Amazon Lex provides the deep functionality and flexibility of natural language understanding (NLU) and automatic speech recognition (ASR) so you can build highly engaging user experiences with lifelike, conversational interactions, and create new categories of products.

Amazon Lex enables any developer to build conversational chatbots quickly. With Amazon Lex, no deep learning expertise is necessary—to create a bot, you just specify the basic conversation flow in the Amazon Lex console. Amazon Lex manages the dialogue and dynamically adjusts the responses in the conversation. Using the console, you can build, test, and publish your text or voice chatbot. You can then add the conversational interfaces to bots on mobile devices, web applications, and chat platforms (for example, Facebook Messenger).

## Server architecture

[FreeSWITCH] <--> [ umrcpserver ] <--> [AWS Lex/Polly] <--> [ Lex Speech Language Understanding (SLU) system ]

     ^.                                       ^
     |                                        |
     v                                        v
[ Lua / Javascript engine ]&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;[ Facebook Messenger / Slack ]

     ^
     |
     v
[ BOT script ] <--> [ External db/web services ]



Preconfigured server will be available in the AWS Marketplace soon!

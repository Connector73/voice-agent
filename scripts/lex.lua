profile = "unimrcp:uni2"
promptCmd = "say: Welcome to Booking service by Connector73. How can I help you?"
-- Compose recognition command
recogCmd = " detect:" .. profile .. " {start-input-timers=false,no-input-timeout=5000}builtin:speech/transcribe"
-- Compose final message
finalMessage = "Thank you. See you next time"
-- constansts
asrtag = "names"

function onInput(s, type, obj)
    	freeswitch.consoleLog("INFO", "BOT Callback with type " .. type .. "\n");
	return "true"
end

freeswitch.consoleLog("INFO", "BOT Started\n")
-- Sleep a little bit to give media time to be fully up.
session:sleep(500)
session:set_tts_params(profile, "Salli");
session:setInputCallback("onInput");

tryagain = 1
-- Magic happens here.
while (session:ready() == true and tryagain == 1) do
        local command = promptCmd .. recogCmd
        freeswitch.consoleLog("INFO", "Command -> " .. command .."\n")
        session:execute("play_and_detect_speech", command)
        local text = session:getVariable('detect_speech_result')
        if (text ~= nil) then
                freeswitch.consoleLog("INFO", "XML <- " .. text .. "\n")
                if string.find(text, "xml") ~= nil then
                        local xml = require("xmlSimple").newParser()
                        local parsedXml = xml:ParseXmlText(text)
                        local dialogstate = parsedXml.result.interpretation.instance.dialogstate:value()
                        freeswitch.consoleLog("INFO", "BOT dialog state: " .. dialogstate .. "\n")
                        if (dialogstate == "ReadyForFulfillment") then
                                freeswitch.consoleLog("INFO", "Ready for fulfillment\n")
                                promptCmd = finalMessage
                                tryagain = 0
                        else
                                local result = parsedXml.result.interpretation.instance.message:value()
                                if (result == nil) then
                                        freeswitch.consoleLog("CRIT","Result is 'nil'\n")
                                        promptCmd = "say: I dont' understand you"
                                else
                                        promptCmd = "say: " .. result
                                end
				tryagain = 1
                        end
                end
        end
end
freeswitch.consoleLog("INFO", "Exit from the BOT\n")
session:speak(promptCmd)
session:sleep(1000)
session:hangup()

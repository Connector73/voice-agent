
// Profile to use
var profile = "unimrcp:uni2";

// Compose initial prompt command
var promptCmd = "say: Welcome to Amazon Lex. How can I help you?";

// Compose recognition command
var recogCmd = " detect:" + profile + " {start-input-timers=false,define-grammar=false,no-input-timeout=10000}builtin:speech/transcribe";

// Compose final message
var finalMessage = "Thank you. See you next time";

// Main recognition loop
while (session.ready()) {
        var command = promptCmd + recogCmd;

        // Play and detect speech
        session.execute("play_and_detect_speech", command);

        // Retrieve result
        var jsonResult = session.getVariable('detect_speech_result');
        if (typeof jsonResult != "undefined") {
                if (jsonResult.indexOf("Completion-Cause:") == -1) {

                        // Parse JSON result
                        var result = JSON.parse(jsonResult);
                        if (typeof result != "undefined") {
                                if (typeof result.transcript != "undefined") {
                                        // Compose next prompt command
                                        promptCmd = "say: " + result.message;
                                }

                                // Check dialog state
                                var state = result.dialogstate;

                                if (typeof state != "undefined") {

                                        if (state == "ReadyForFulfillment") {

                                                break;
                                        }
                                }
                        }
                }
                else {
                        consoleLog("INFO", "Recognition completed abnormally!\n");
                }
        }
        else {
                consoleLog("INFO", "No result!\n");
                break;
        }
}
 
// Speak the final message
session.speak(profile, "", finalMessage);

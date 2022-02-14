import std/os
import winim


type
  SendKeys = array[2, INPUT]

var inputs: SendKeys

# Key Down event
inputs[0].type = INPUT_KEYBOARD
inputs[0].ki.wVk = VK_LWIN

# Key Up event
inputs[1].type = INPUT_KEYBOARD
inputs[1].ki.wVk = VK_LWIN
inputs[1].ki.dwFlags = KEYEVENTF_KEYUP

# Send input every 60 seconds
while true:
    SendInput((UINT)len(inputs), &inputs[0], (int32)sizeof(INPUT));
    sleep(60000)
import std/os
import std/random
import winim


type
  SendKeys = array[4, INPUT]

var inputs: SendKeys

inputs[0].type = INPUT_KEYBOARD
inputs[0].ki.wVk = VK_MENU

inputs[1].type = INPUT_KEYBOARD
inputs[1].ki.wVk = VK_F4

inputs[2].type = INPUT_KEYBOARD
inputs[2].ki.wVk = VK_F4
inputs[2].ki.dwFlags = KEYEVENTF_KEYUP

inputs[3].type = INPUT_KEYBOARD
inputs[3].ki.wVk = VK_MENU
inputs[3].ki.dwFlags = KEYEVENTF_KEYUP

# Send keypress randomly
while true:
    SendInput((UINT)len(inputs), &inputs[0], (int32)sizeof(INPUT));
    sleep(rand(30000))
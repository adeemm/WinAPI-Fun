import winim


type
    SendKeys = array[12, INPUT]

proc SendSpace() = 
    var inputs: SendKeys

    # Hold shift for caps
    inputs[0].type = INPUT_KEYBOARD
    inputs[0].ki.wVk = VK_SHIFT 

    # S key
    inputs[1].type = INPUT_KEYBOARD
    inputs[1].ki.wVk = 0x53 
    inputs[2].type = INPUT_KEYBOARD
    inputs[2].ki.wVk = 0x53
    inputs[2].ki.dwFlags = KEYEVENTF_KEYUP

    # P key
    inputs[3].type = INPUT_KEYBOARD
    inputs[3].ki.wVk = 0x50
    inputs[4].type = INPUT_KEYBOARD
    inputs[4].ki.wVk = 0x50
    inputs[4].ki.dwFlags = KEYEVENTF_KEYUP

    # A key
    inputs[5].type = INPUT_KEYBOARD
    inputs[5].ki.wVk = 0x41
    inputs[6].type = INPUT_KEYBOARD
    inputs[6].ki.wVk = 0x41
    inputs[6].ki.dwFlags = KEYEVENTF_KEYUP

    # C key
    inputs[7].type = INPUT_KEYBOARD
    inputs[7].ki.wVk = 0x43
    inputs[8].type = INPUT_KEYBOARD
    inputs[8].ki.wVk = 0x43
    inputs[8].ki.dwFlags = KEYEVENTF_KEYUP

    # E key
    inputs[9].type = INPUT_KEYBOARD
    inputs[9].ki.wVk = 0x45
    inputs[10].type = INPUT_KEYBOARD
    inputs[10].ki.wVk = 0x43
    inputs[10].ki.dwFlags = KEYEVENTF_KEYUP

    # Release shift key
    inputs[11].type = INPUT_KEYBOARD
    inputs[11].ki.wVk = VK_SHIFT
    inputs[11].ki.dwFlags = KEYEVENTF_KEYUP

    SendInput((UINT)len(inputs), &inputs[0], (int32)sizeof(INPUT));


# Run callback everytime key is pressed
proc HookCallback(nCode: int32, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} =    

    if (bool(lParam)):
        var kbd: PKBDLLHOOKSTRUCT = cast[ptr KBDLLHOOKSTRUCT](lparam)

        if (kbd.vkCode == VK_SPACE):
            if (wParam == WM_KEYDOWN):
                SendSpace()
                return 1
            elif (wParam == WM_KEYUP):
                return 1

    return CallNextHookEx(0, nCode, wParam, lParam)


# Hook LowLevelKeyboardProc
var hook = SetWindowsHookEx(WH_KEYBOARD_LL, (HOOKPROC) HookCallback, 0,  0)
if bool(hook):
    try:
        PostMessage(0, 0, 0, 0)
        var msg: MSG
        while GetMessage(msg.addr, 0, 0, 0):
            discard
    
    finally:
        UnhookWindowsHookEx(hook)

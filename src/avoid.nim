import std/random
import winim


let hWndTaskBar = FindWindow("Shell_TrayWnd", NULL);
let hWndStart = FindWindowEx(hWndTaskBar, 0x0, "Start", "Start");

var cursor: POINT
GetCursorPos(&cursor)

var rectTaskBar: RECT
GetWindowRect(hWndTaskBar, &rectTaskBar)

var rectStart: RECT
GetWindowRect(hWndStart, &rectStart)

# Reset Start Button Position
SetWindowPos(hWndStart, 0x0, 0, 0, 0, 0, (SWP_NOSIZE or SWP_NOZORDER))

var upperBound = rectTaskBar.right - rectStart.right;


# Run callback everytime mouse is moved 
proc HookCallback(nCode: int32, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} =    
    GetCursorPos(&cursor)

    if cursor.x >= rectStart.left and cursor.x <= rectStart.right and cursor.y >= rectStart.top:
        var newX = rand(upperBound)
        SetWindowPos(hWndStart, 0x0, (int32)newX, 0, 0, 0, (SWP_NOSIZE or SWP_NOZORDER))
        GetWindowRect(hWndStart, &rectStart)

    return CallNextHookEx(0, nCode, wParam, lParam)


# Hook LowLevelMouseProc
var hook = SetWindowsHookEx(WH_MOUSE_LL, (HOOKPROC) HookCallback, 0,  0)
if bool(hook):
    try:
        PostMessage(0, 0, 0, 0)
        var msg: MSG
        while GetMessage(msg.addr, 0, 0, 0):
            discard
    
    finally:
        UnhookWindowsHookEx(hook)

import winim


const stopImage = slurp("../res/stop.bmp")
var pixelArrayOffset = ord(stopImage[10..13][0])

# Window Stuff
var
    hInstance = GetModuleHandle(nil)
    hwnd: HWND
    msg: MSG
    wndclass: WNDCLASS
    bmpBackground = CreateBitmap(75, 75, 1, 32, &stopImage[pixelArrayOffset..^1])
    timerID = 1337


# Handle Message Pump
proc WindowProc(hwnd: HWND, message: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} =
    case message
    of WM_DESTROY:
        KillTimer(hwnd, timerID)
        PostQuitMessage(0)
        return 0

    of WM_TIMER:
        var point: POINT
        GetCursorPos(&point)
        SetWindowPos(hwnd, HWND_TOPMOST, (point.x - 37), (point.y - 37), 0, 0, (SWP_NOSIZE or SWP_NOZORDER))
        return 0

    else:
        return DefWindowProc(hwnd, message, wParam, lParam)


# Boilerplate to create window
wndclass.style = CS_HREDRAW or CS_VREDRAW
wndclass.lpfnWndProc = WindowProc
wndclass.hInstance = hInstance
wndclass.hbrBackground = CreatePatternBrush(bmpBackground)
wndclass.lpszClassName = "MouseStopSign"
RegisterClass(wndclass)

hwnd = CreateWindowExW(WS_EX_TOPMOST or WS_EX_LAYERED, "MouseStopSign", "Mouse Stop Sign", WS_POPUP or WS_VISIBLE, CW_USEDEFAULT, CW_USEDEFAULT, 0, 0, 0, 0, hInstance, NULL)
SetLayeredWindowAttributes(hWnd, RGB(0, 0, 0), 255, LWA_ALPHA or LWA_COLORKEY)

ShowWindow(hwnd, SW_SHOW)
UpdateWindow(hwnd)
SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 75, 75, SWP_SHOWWINDOW)

# Run timer to repeatedly set window position
SetTimer(hwnd, timerID, 50, NULL)

while GetMessage(msg, 0, 0, 0) != 0:
        TranslateMessage(msg)
        DispatchMessage(msg)
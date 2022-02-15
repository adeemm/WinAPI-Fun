import os
import system/io
import winim


const CURSOR = slurp("../res/finger.cur")
var TEMP = getEnv("TEMP") & DirSep & "cursor.cur"

# Extract embedded cursor to temp dir
let f = open(TEMP, fmWrite)
write(f, CURSOR)
f.close()

var hCursor = LoadCursorFromFileA(TEMP)
SetCursor(hCursor)


# Window Stuff
var
    hInstance = GetModuleHandle(nil)
    hwnd: HWND
    msg: MSG
    wndclass: WNDCLASS


# Get display size
var dm: DEVMODE
EnumDisplaySettings(NULL, ENUM_CURRENT_SETTINGS, &dm)


# Handle Message Pump
proc WindowProc(hwnd: HWND, message: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} =
    case message
    of WM_DESTROY:
        DestroyCursor(hCursor)
        PostQuitMessage(0)
        return 0

    of WM_SETCURSOR: 
       SetCursor(hCursor)

    of WM_MOVING:
        SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, dm.dmPelsWidth, dm.dmPelsHeight, SWP_SHOWWINDOW)
        return 1

    of WM_MOVE:
        SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, dm.dmPelsWidth, dm.dmPelsHeight, SWP_SHOWWINDOW)
        return 0

    else:
        return DefWindowProc(hwnd, message, wParam, lParam)


# Boilerplate to create window
wndclass.style = CS_HREDRAW or CS_VREDRAW
wndclass.lpfnWndProc = WindowProc
wndclass.hInstance = hInstance
wndclass.hCursor = hCursor
wndclass.hbrBackground = GetStockObject(WHITE_BRUSH)
wndclass.lpszClassName = "CustomCursor"
RegisterClass(wndclass)

hwnd = CreateWindowExW(WS_EX_TOPMOST or WS_EX_LAYERED, "CustomCursor", "Custom Cursor", WS_POPUP or WS_VISIBLE, CW_USEDEFAULT, CW_USEDEFAULT, 0, 0, 0, 0, hInstance, NULL)
SetLayeredWindowAttributes(hWnd, RGB(0, 0, 0), 1, LWA_ALPHA or LWA_COLORKEY)

ShowWindow(hwnd, SW_SHOW)
UpdateWindow(hwnd)

# Cover everything
SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, dm.dmPelsWidth, dm.dmPelsHeight, SWP_SHOWWINDOW)

while GetMessage(msg, 0, 0, 0) != 0:
    TranslateMessage(msg)
    DispatchMessage(msg)
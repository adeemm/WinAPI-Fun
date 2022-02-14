import winim


var
    hInstance = GetModuleHandle(nil)
    hwnd: HWND
    msg: MSG
    wndclass: WNDCLASS

    
# Handle Message Pump
proc WindowProc(hwnd: HWND, message: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} =
    case message
    of WM_DESTROY:
        PostQuitMessage(0)
        return 0

    of WM_CLOSE, WM_QUERYENDSESSION:
        return 0

    else:
        return DefWindowProc(hwnd, message, wParam, lParam)


# Boilerplate to create window
wndclass.style = CS_HREDRAW or CS_VREDRAW
wndclass.lpfnWndProc = WindowProc
wndclass.cbClsExtra = 0
wndclass.cbWndExtra = 0
wndclass.hInstance = hInstance
wndclass.hIcon = LoadIcon(0, IDI_APPLICATION)
wndclass.hCursor = LoadCursor(0, IDC_ARROW)
wndclass.hbrBackground = GetStockObject(WHITE_BRUSH)
wndclass.lpszMenuName = nil
wndclass.lpszClassName = "StopShutdown"
RegisterClass(wndclass)

hwnd = CreateWindow("StopShutdown", "Stop Shutdown", WS_MINIMIZE, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, 0, 0, hInstance, nil)

ShutdownBlockReasonCreate(hwnd, "Nice Try")

while GetMessage(msg, 0, 0, 0) != 0:
    TranslateMessage(msg)
    DispatchMessage(msg)
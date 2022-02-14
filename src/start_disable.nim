import winim


let hWndTaskBar = FindWindow("Shell_TrayWnd", NULL);
let hWndStart = FindWindowEx(hWndTaskBar, 0x0, "Start", "Start");

# If the windows are already disabled, re-enable them
if (EnableWindow(hWndStart, FALSE) or EnableWindow(hWndTaskBar, FALSE)):
    EnableWindow(hWndStart, TRUE)
    EnableWindow(hWndTaskBar, TRUE)
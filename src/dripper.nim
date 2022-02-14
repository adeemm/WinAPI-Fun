import os
import winim


var windowCoords: RECT

while true:
    var hWnd = GetForegroundWindow()
    GetWindowRect(hWnd, &windowCoords)

    SetWindowPos(hWnd, 0x0, windowCoords.left, windowCoords.top + 2, 0, 0, (SWP_NOSIZE or SWP_NOZORDER))
    sleep(10000)
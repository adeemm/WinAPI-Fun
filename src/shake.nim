import os
import std/random
import winim


var hWndOrig = GetForegroundWindow()
var windowCoords: RECT
GetWindowRect(hWndOrig, &windowCoords)

while true:
    var hWndNew = GetForegroundWindow()
    
    if (hWndNew != hWndOrig):
        hWndOrig = hWndNew
        GetWindowRect(hWndOrig, &windowCoords)

    var
        newX = rand(windowCoords.left - 3 .. windowCoords.left + 3)
        newY = rand(windowCoords.top - 3 .. windowCoords.top + 3)

    SetWindowPos(hWndOrig, 0x0, (int32)newX, (int32)newY, 0, 0, (SWP_NOSIZE or SWP_NOZORDER))
    sleep(10)
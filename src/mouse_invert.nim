import os
import winim


# Get screen bounds
var dm: DEVMODE
EnumDisplaySettings(NULL, ENUM_CURRENT_SETTINGS, &dm)

var oldPoint: POINT
GetCursorPos(&oldPoint)

while true:
    var newPoint: POINT
    GetCursorPos(&newPoint)

    var
        dx = newPoint.x - oldPoint.x
        dy = newPoint.y - oldPoint.y
        newX = oldPoint.x - dx
        newY = oldPoint.y - dy

    # Dont move mouse past screen bounds
    newX = clamp(newX, int32(0), dm.dmPelsWidth)
    newY = clamp(newY, int32(0), dm.dmPelsHeight)

    SetCursorPos(newX, newY)

    newPoint.x = newX
    newPoint.y = newY
    oldPoint = newPoint

    sleep(2)
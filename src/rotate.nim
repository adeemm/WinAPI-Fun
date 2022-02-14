import winim


var dm: DEVMODE
EnumDisplaySettings(NULL, ENUM_CURRENT_SETTINGS, &dm)

if (dm.dmDisplayOrientation == DMDO_DEFAULT):
    dm.dmDisplayOrientation = DMDO_180
else:
    dm.dmDisplayOrientation = DMDO_DEFAULT

ChangeDisplaySettings(&dm, 0)
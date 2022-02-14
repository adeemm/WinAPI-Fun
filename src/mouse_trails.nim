import std/random
import winim


var trails: int32
SystemParametersInfoA(SPI_GETMOUSETRAILS, 0, &trails, 0)

if (trails < 2):
    trails = (int32)rand(2..9)
else:
    trails = 0

SystemParametersInfoA(SPI_SETMOUSETRAILS, trails, NULL, 0)
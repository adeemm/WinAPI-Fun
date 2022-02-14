import std/os
import winim


var rect: RECT
SetRect(&rect, 0, 0, 100, 100);

ClipCursor(&rect);
sleep(60000)
ClipCursor(NULL);
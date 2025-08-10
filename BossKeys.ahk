#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global toonlist := []

;WinGet, toonlist, List, Toontown Rewritten
WinGet, toonlist, List, Corporate Clash

;Control::Send, {Control}
;return

#IfWinActive Corporate Clash
;jump on all toons
Control::
    Loop, %toonlist% {
        this_id := toonlist%A_Index%
        ControlSend,, {Control Down}, ahk_id %this_id%
        Sleep, 2
        ControlSend,, {Control Up}, ahk_id %this_id%
    }
return

#IfWinActive Corporate Clash
4::
    while GetKeyState("4","P")
    {
        Send, {f}
        Sleep, 2
    }
return

#IfWinActive Toontown Multicontroller
4::
    while GetKeyState("4","P")
    {
        Send, {f}
        Sleep, 2
    }
return

#IfWinActive Corporate Clash 
;5::
;    Loop, %toonlist% {
;        this_id := toonlist%A_Index%
;        ControlSend,, {F Down}, ahk_id %this_id%
;        Sleep, 1
;        ControlSend,, {F Up}, ahk_id %this_id%
;    }
;return

#IfWinActive Corporate Clash
;bigger pie throughs
;5::
;    while GetKeyState("6","P")
;    {
;        Loop, %toonlist% {
;            this_id := toonlist%A_Index%
;            ControlSend,, {F Down}, ahk_id %this_id%
;            Sleep, 80
;            ControlSend,, {F Up}, ahk_id %this_id%
;            Sleep, 2
;        }
;    }
;return

#IfWinActive Toontown Multicontroller
;bigger pie throughs
5::
    Send, {f Down}
    KeyWait, %A_ThisHotkey%
    Send, {f Up}
return

#IfWinActive Corporate Clash
;bigger pie throughs
5::
    Send, {f Down}
    KeyWait, %A_ThisHotkey%
    Send, {f Up}
return

#IfWinActive Corporate Clash
;hold down 5 to throw long pies on all toons
6::
    while GetKeyState("5","P")
    {
        Loop, %toonlist% {
            this_id := toonlist%A_Index%
            ControlSend,, {F Down}, ahk_id %this_id%
            ;Sleep, 1
            ControlSend,, {F Up}, ahk_id %this_id%
            Sleep, 1
        }
    }
return




;#IfWinActive Corporate Clash
;6::
;this_id := toonlist%A_Index%
;ControlSend,, {F Down}, ahk_id %this_id%
;KeyWait, %A_ThisHotkey%
;ControlSend,, {F Up}, ahk_id %this_id%
;Loop, %toonlist% {
;    this_id := toonlist%A_Index%
;    ControlSend,, {Delete Down}, ahk_id %this_id%
;    KeyWait, %A_ThisHotkey%
;    ControlSend,, {Delete Up}, ahk_id %this_id%
;}
return

#IfWinActive Corporate Clash
7::Reload
return

#IfWinActive Corporate Clash
f12::
Suspend
return

;#IfWinActive Corporate Clash
;;speedway go forward
;8::
;thiswin := WinExist("A")
;Loop {
;    ControlSend,, {W Down}, ahk_id %thiswin%
;}
;
;;Loop, 4 {
;;    this_id := toonlist%A_Index%
;;    ControlSend,, {W Down}, ahk_id %this_id%
;;}
;return
;
;#IfWinActive Corporate Clash
;;speedway go forward
;9::
;thiswin := WinExist("A")
;ControlSend,, {W Up}, ahk_id %thiswin%
;;Loop, 4 {
;;    this_id := toonlist%A_Index%
;;    ControlSend,, {W Up}, ahk_id %this_id%
;;}
;return

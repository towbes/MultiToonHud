#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global toonlist := []

WinGet, toonlist, List, Toontown Rewritten

Control::Send, {Control}
return

4::
    Loop, %toonlist% {
        this_id := toonlist%A_Index%
        ControlSend,, {Ctrl Down}, ahk_id %this_id%
        Sleep, 2
        ControlSend,, {Ctrl Up}, ahk_id %this_id%
    }
return

5::
    while GetKeyState("5","P")
    {
        Loop, %toonlist% {
            this_id := toonlist%A_Index%
            ControlSend,, {Delete}, ahk_id %this_id%
            Sleep, 2
        }
    }
return

6::
Loop, %toonlist% {
    this_id := toonlist%A_Index%
    ControlSend,, {Delete Down}, ahk_id %this_id%
    KeyWait, %A_ThisHotkey%
    ControlSend,, {Delete Up}, ahk_id %this_id%
}
return

7::Reload
return

f12::
Suspend
return

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
;
;;speedway go forward
;9::
;thiswin := WinExist("A")
;ControlSend,, {W Up}, ahk_id %thiswin%
;;Loop, 4 {
;;    this_id := toonlist%A_Index%
;;    ControlSend,, {W Up}, ahk_id %this_id%
;;}
;return

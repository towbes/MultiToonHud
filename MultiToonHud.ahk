;AHK script
#SingleInstance, Force		; Force a single instance of this script
#NoEnv  					; For performance and compatibility with future AHK releases.
#Warn  						; Enable warnings to assist with detecting common errors.

global toonlist := []
global toonid := []
CoordMode, Mouse, Window

;Load toonid's from inifile
;Setup an INI file to store the indexes of toons

if FileExist("toons.ini") {
	;IniRead, temp, toons.ini, main, 1, 1
	;toonid[1] := temp
	;MsgBox % "A_Index: " . idnum
	Loop, 8 {
		idnum := A_Index
		temp := 0
		IniRead, temp, toons.ini, main, %idnum%, 1
		toonid[idnum] := temp
		;MsgBox % "id: " . idnum . " Toonid: " . toonid[idnum]
	}
}

;Todo
;Make window mover a screen with options for resolution / borderless / position 
;Adjust click positions so they are indepdendant of resolution https://www.autohotkey.com/boards/viewtopic.php?t=67335
;make a checkbox to enable click in all windows at one time

;Screen Resoulution, currently only width is used to calculate sizes
;Best to use borderless window
global screenwidth := 2560
global screenheight := 1440

;coordinates for gags with 2560/4 x 2560/4 windows
;fill up jellybeans
;left arrow coords: 320, 360
;gag positions
;210,294
;255,294
;305,294
;355,294
;400,294
;445,294
;495,294
;;toonup
;Feather
;Megaphone
;Lipstick
;Bamboo Cane
;Pixie Dust
;Juggling Balls
;High Dive
;tudict := {"tu1" : "210,168","tu2" : "255,168","tu3" : "305,168","tu4" : "355,168","tu5" : "400,168","tu6" : "445,168","tu7" : "495,168"}
;trapdict := {"tr1" : "210,200", "tr2" : "255,200", "tr3" : "305,200", "tr4" : "355,200", "tr5" : "400,200", "tr6" : "445,200", "tr7" : "495,200"}
gagdict := {"tu1" : "x210 y168","tu2" : "x255 y168","tu3" : "x305 y168","tu4" : "x355 y168","tu5" : "x400 y168","tu6" : "x445 y168","tu7" : "x495 y168","tr1" : "x210 y200", "tr2" : "x255 y200", "tr3" : "x305 y200", "tr4" : "x355 y200", "tr5" : "x400 y200", "tr6" : "x445 y200", "tr7" : "x495 y200","lu1" : "x210 y233","lu2" : "x255 y233","lu3" : "x305 y233","lu4" : "x355 y233","lu5" : "x400 y233","lu6" : "x445 y233","lu7" : "x495 y233","so1" : "x210 y260","so2" : "x255 y260","so3" : "x305 y260","so4" : "x355 y260","so5" : "x400 y260","so6" : "x445 y260","so7" : "x495 y260","th1" : "x210 y294","th2" : "x255 y294","th3" : "x305 y294","th4" : "x355 y294","th5" : "x400 y294","th6" : "x445 y294","th7" : "x495 y294","sq1" : "x210 y328","sq2" : "x255 y328","sq3" : "x305 y328","sq4" : "x355 y328","sq5" : "x400 y328","sq6" : "x445 y328","sq7" : "x495 y328","dr1" : "x210 y356","dr2" : "x255 y356","dr3" : "x305 y356","dr4" : "x355 y356","dr5" : "x400 y356","dr6" : "x445 y356","dr7" : "x495 y356"}

;;trap
;Banana Peel
;Rake
;Marbles
;Quicksand
;Trapdoor
;TNT
;Railroad
;trapdict := {"tr1" : "210,200", "tr2" : "255,200", "tr3" : "305,200", "tr4" : "355,200", "tr5" : "400,200", "tr6" : "445,200", "tr7" : "495,200"}


;;lure
;$1 Bill
;Small Magnet
;$5 Bill
;Big Magnet
;$10 Bill
;Hypno Goggles
;Presentation
;luredict := {"lu1" : "210,233","lu2" : "255,233","lu3" : "305,233","lu4" : "355,233","lu5" : "400,233","lu6" : "445,233","lu7" : "495,233"}

;;sound
;Bike Horn
;Whistle
;Bugle
;Aoogah
;Elephant Trunk
;Foghorn
;Opera Singer
;sounddict := {"so1" : "210,260","so2" : "255,260","so3" : "305,260","so4" : "355,260","so5" : "400,260","so6" : "445,260","so7" : "495,260"}

;;throw
;cupcake 210,294
;fruit pie slice 255,294
;cream pie slice 305,294
;fruit pie 355,294
;cream pie 400,294
;birthday cake 445,294
;Wedding Cake
;throwgags := {"th1" : "210,294","th2" : "255,294","th3" : "305,294","th4" : "355,294","th5" : "400,294","th6" : "445,294","th7" : "495,294"}

;;squirt
;Squirting Flower
;Glass of Water
;Squirt Gun
;Seltzer Bottle
;Fire Hose
;Storm Cloud
;Geyser
;squirtdict := {"sq1" : "210,328","sq2" : "255,328","sq3" : "305,328","sq4" : "355,328","sq5" : "400,328","sq6" : "445,328","sq7" : "495,328"}

;;drop
;Flower Pot
;Sandbag
;Anvil
;Big Weight
;Safe
;Grand Piano
;Toontanic
;dropdict := {"dr1" : "210,356","dr2" : "255,356","dr3" : "305,356","dr4" : "355,356","dr5" : "400,356","dr6" : "445,356","dr7" : "495,356"}




; -- Initialize the GUI
InitGUI()

return

InitGUI() {
	global
	NumOfButtons = 0
	DistanceBetweenControls = 5
	HeightOfControls := GetButtonDefaultHeight()
	;Gui Loop
	;Create sub-menus
	Menu, FileMenu, Add, Move Windows, MoveWindows
	Menu, FileMenu, Add, Accounts, ShowAccounts
	Menu, ProfileMenu, Add, View Profiles, OpenProfiles

	Menu, MyMenuBar, Add, File, :FileMenu
	Menu, MyMenuBar, Add, Profile, :ProfileMenu
	Gui, Menu, MyMenuBar

	;DrawGui
	Gui, Add, Tab3,, Main|Boss|Travel
	Gui, Add, Text, section, Buy Gags
	Gui, Add, Button, w25 vgag1 gGetGags, 1
	Gui, Add, Button, x+5 w25 vgag2 gGetGags, 2
	Gui, Add, Button, x+5 w25 vgag5 gGetGags, 5
	Gui, Add, Button, x+5 w25 vgag6 gGetGags, 6
	Gui, Add, Button, xs w25 vgag3 gGetGags, 3
	Gui, Add, Button, x+5 w25 vgag4 gGetGags, 4
	Gui, Add, Button, x+5 w25 vgag7 gGetGags, 7
	Gui, Add, Button, x+5 w25 vgag8 gGetGags, 8
	Gui, Add, Text, xs section, Get Beans
	Gui, Add, Button, w25 vbean1 gGetBeans, 1
	Gui, Add, Button, x+5 w25 vbean2 gGetBeans, 2
	Gui, Add, Button, x+5 w25 vbean5 gGetBeans, 5
	Gui, Add, Button, x+5 w25 vbean6 gGetBeans, 6
	Gui, Add, Button, xs w25 vbean3 gGetBeans, 3
	Gui, Add, Button, x+5 w25 vbean4 gGetBeans, 4
	Gui, Add, Button, x+5 w25 vbean7 gGetBeans, 7
	Gui, Add, Button, x+5 w25 vbean8 gGetBeans, 8
	Gui, Add, Text, xs section, Go Home
	Gui, Add, Button, w25 vhome1 gSendHome, 1
	Gui, Add, Button, x+5 w25 vhome2 gSendHome, 2
	Gui, Add, Button, x+5 w25 vhome5 gSendHome, 5
	Gui, Add, Button, x+5 w25 vhome6 gSendHome, 6
	Gui, Add, Button, xs w25 vhome3 gSendHome, 3
	Gui, Add, Button, x+5 w25 vhome4 gSendHome, 4
	Gui, Add, Button, x+5 w25 vhome7 gSendHome, 7
	Gui, Add, Button, x+5 w25 vhome8 gSendHome, 8
	Gui, Add, Text, xs section, Go Playground
	Gui, Add, Button, w25 vpg1 gSendPlayground, 1
	Gui, Add, Button, x+5 w25 vpg2 gSendPlayground, 2
	Gui, Add, Button, x+5 w25 vpg5 gSendPlayground, 5
	Gui, Add, Button, x+5 w25 vpg6 gSendPlayground, 6
	Gui, Add, Button, xs w25 vpg3 gSendPlayground, 3
	Gui, Add, Button, x+5 w25 vpg4 gSendPlayground, 4
	Gui, Add, Button, x+5 w25 vpg7 gSendPlayground, 7
	Gui, Add, Button, x+5 w25 vpg8 gSendPlayground, 8
	Gui, Tab, 2
	Gui, Add, Text, section, Boss PH
	Gui, Tab, 3
	Gui, Add, Text, section, Boss PH
	;Gui, Add, Edit, vHomeIndex
	;Gui, Add, Button, gSendHome w100, Go Home
	; Alternatively, Link controls can be used:
	Gui, Font, norm
	Gui, +resize
	Gui, Show, W200 H400
	return
}


OpenProfiles:
Gui, New
Gui, Add, Text, section, Select Toon 
Gui, Add, DropDownList, vProfileIndex gGetProfile, Toon1|Toon2|Toon3|Toon4|Toon5|Toon6|Toon7|Toon8
Gui, Add, Button, x+5 gSaveProfile, Save
Gui, Add, Text, w50 xs section, Rank
Gui, Add, Text, x+15 w20, 1
Gui, Add, Text, x+20 w20, 2
Gui, Add, Text, x+20 w20, 3
Gui, Add, Text, x+20 w20, 4
Gui, Add, Text, x+20 w20, 5
Gui, Add, Text, x+20 w20, 6
Gui, Add, Text, x+20 w20, 7
Gui, Add, Text, w50 xs section, Toon Up
Gui, Add, Edit, x+10 w20 Limit2 Number vtu1, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtu2, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtu3, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtu4, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtu5, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtu6, 0
Gui, Add, Text, w50 xs section, Trap
Gui, Add, Edit, x+10 w20 Limit2 Number vtr1, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtr2, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtr3, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtr4, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtr5, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vtr6, 0
Gui, Add, Text, w50 xs section, Lure
Gui, Add, Edit, x+10 w20 Limit2 Number vlu1, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vlu2, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vlu3, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vlu4, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vlu5, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vlu6, 0
Gui, Add, Text, w50 xs section, Sound
Gui, Add, Edit, x+10 w20 Limit2 Number vso1, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vso2, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vso3, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vso4, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vso5, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vso6, 0
Gui, Add, Text, w50 xs section, Throw
Gui, Add, Edit, x+10 w20 Limit2 Number vth1, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vth2, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vth3, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vth4, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vth5, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vth6, 0
Gui, Add, Text, w50 xs section, Squirt
Gui, Add, Edit, x+10 w20 Limit2 Number vsq1, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vsq2, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vsq3, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vsq4, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vsq5, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vsq6, 0
Gui, Add, Text, w50 xs section, Drop
Gui, Add, Edit, x+10 w20 Limit2 Number vdr1, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vdr2, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vdr3, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vdr4, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vdr5, 0
Gui, Add, Edit, x+20 w20 Limit2 Number vdr6, 0
Gui, Show,, Gag Profiles
return  ; End of auto-execute section. The script is idle until the user does something.


GetProfile:
Gui, Submit, NoHide
tempindex := RegExReplace(ProfileIndex, "\D")
;MsgBox % "You pressed: " tempindex
UpdateProfile(tempindex)
return

SaveProfile:
Gui, Submit, NoHide
tempindex := RegExReplace(ProfileIndex, "\D")
;MsgBox % "You pressed: " tempindex
SaveGags(tempindex)
return

GetGags:
tempindex := RegExReplace(A_GuiControl, "\D")
;MsgBox % "You pressed: " tempindex
BuyGags(tempindex)
return

GetBeans:
tempindex := RegExReplace(A_GuiControl, "\D")
;MsgBox % "You pressed: " tempindex
ClickBeans(tempindex)
return

SendHome:
tempindex := RegExReplace(A_GuiControl, "\D")
;MsgBox % "You pressed: " tempindex
GoHome(tempindex)
return

SendPlayground:
tempindex := RegExReplace(A_GuiControl, "\D")
;MsgBox % "You pressed: " tempindex
GoPlayground(tempindex)
return

MoveWindows:
WinGet, toonlist, List, Toontown Rewritten
SetWindows()
return

ShowAccounts:
IniRead, KeyNames, accountinfo.ini, accounts
Loop, Parse, KeyNames, `n, `r
{
	tmpKeyArr := StrSplit(A_LoopField, "=")
	;MsgBox, % A_Index
	IniRead, ValueNames, accountinfo.ini, accounts, % tmpKeyArr[1]
	;MsgBox, % ValueNames
	Run, Launcher.exe, C:\Program Files (x86)\Toontown Rewritten\
	WinWaitActive, Toontown Rewritten Launcher
	
	Click 630, 336
	Sleep 100
	SendInput, % tmpKeyArr[1] ; Put your credentials here
	Sleep 100
	Click 671, 381
	Sleep 100
	SendInput, % tmpKeyArr[2]
	Sleep 100
	Click 785, 381 ; Click the big red button
	;Wait for the TTR window to be active
	WinWaitActive Toontown Rewritten
	WinGet, tempwinid
	toonlist[A_Index] := tempwinid
	;MsgBox, % A_Index " " toonlist[A_Index]
	Sleep 5000
}
return


UpdateProfile(ToonIndex) {
	global
	Gui, Submit, NoHide
	local tempgag := 0
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu1, 0
	GuiControl,, tu1, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu2, 0
	GuiControl,, tu2, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu3, 0
	GuiControl,, tu3, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu4, 0
	GuiControl,, tu4, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu5, 0
	GuiControl,, tu5, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu6, 0
	GuiControl,, tu6, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr1, 0
	GuiControl,, tr1, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr2, 0
	GuiControl,, tr2, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr3, 0
	GuiControl,, tr3, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr4, 0
	GuiControl,, tr4, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr5, 0
	GuiControl,, tr5, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr6, 0
	GuiControl,, tr6, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu1, 0
	GuiControl,, lu1, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu2, 0
	GuiControl,, lu2, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu3, 0
	GuiControl,, lu3, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu4, 0
	GuiControl,, lu4, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu5, 0
	GuiControl,, lu5, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu6, 0
	GuiControl,, lu6, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so1, 0
	GuiControl,, so1, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so2, 0
	GuiControl,, so2, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so3, 0
	GuiControl,, so3, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so4, 0
	GuiControl,, so4, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so5, 0
	GuiControl,, so5, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so6, 0
	GuiControl,, so6, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th1, 0
	GuiControl,, th1, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th2, 0
	GuiControl,, th2, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th3, 0
	GuiControl,, th3, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th4, 0
	GuiControl,, th4, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th5, 0
	GuiControl,, th5, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th6, 0
	GuiControl,, th6, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq1, 0
	GuiControl,, sq1, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq2, 0
	GuiControl,, sq2, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq3, 0
	GuiControl,, sq3, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq4, 0
	GuiControl,, sq4, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq5, 0
	GuiControl,, sq5, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq6, 0
	GuiControl,, sq6, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr1, 0
	GuiControl,, dr1, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr2, 0
	GuiControl,, dr2, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr3, 0
	GuiControl,, dr3, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr4, 0
	GuiControl,, dr4, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr5, 0
	GuiControl,, dr5, %tempgag%
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr6, 0
	GuiControl,, dr6, %tempgag%
	;MsgBox % "You pressed: " tempgag
}

;Click beans arrow for given index
BuyGags(ToonIndex) {
	global
	local tempgag := 0
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu1, 1
	ClickGag("tu1", tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu2, 1
	ClickGag("tu2", tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu3, 1
	ClickGag("tu3"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu4, 1
	ClickGag("tu4"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu5, 1
	ClickGag("tu5"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tu6, 1
	ClickGag("tu6"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr1, 1
	ClickGag("tr1"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr2, 1
	ClickGag("tr2"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr3, 1
	ClickGag("tr3"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr4, 1
	ClickGag("tr4"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr5, 1
	ClickGag("tr5"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, tr6, 1
	ClickGag("tr6"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu1, 1
	ClickGag("lu1"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu2, 1
	ClickGag("lu2"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu3, 1
	ClickGag("lu3"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu4, 1
	ClickGag("lu4"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu5, 1
	ClickGag("lu5"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, lu6, 1
	ClickGag("lu6"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so1, 1
	ClickGag("so1"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so2, 1
	ClickGag("so2"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so3, 1
	ClickGag("so3"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so4, 1
	ClickGag("so4"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so5, 1
	ClickGag("so5"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, so6, 1
	ClickGag("so6"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th1, 1
	ClickGag("th1"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th2, 1
	ClickGag("th2"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th3, 1
	ClickGag("th3"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th4, 1
	ClickGag("th4"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th5, 1
	ClickGag("th5"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, th6, 1
	ClickGag("th6"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq1, 1
	ClickGag("sq1"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq2, 1
	ClickGag("sq2"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq3, 1
	ClickGag("sq3"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq4, 1
	ClickGag("sq4"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq5, 1
	ClickGag("sq5"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, sq6, 1
	ClickGag("sq6"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr1, 1
	ClickGag("dr1"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr2, 1
	ClickGag("dr2"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr3, 1
	ClickGag("dr3"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr4, 1
	ClickGag("dr4"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr5, 1
	ClickGag("dr5"  , tempgag, ToonIndex)
	IniRead, tempgag, toons.ini, toon%ToonIndex%, dr6, 1
	ClickGag("dr6"  , tempgag, ToonIndex)
}

ClickGag(gagid, numgags, ToonIndex) {
	global
	;MsgBox % "Buying Quantity: " numgags " Position: " gagdict[gagid]
	SetMouseDelay, 50
	local this_id := toonid[ToonIndex]
	local pos_string := gagdict[gagid]
	;MsgBox % pos_string
	;600, 590 book location
	ControlClick, %pos_string%, ahk_id %this_id%,,,numgags
	Sleep 100
}

;Save gags to ini
SaveGags(ToonIndex) {
	global
	Gui, Submit, NoHide
	local this_id := toonid[ToonIndex]
	IniWrite, %tu1%, toons.ini, toon%ToonIndex%, tu1
	IniWrite, %tu2%, toons.ini, toon%ToonIndex%, tu2
	IniWrite, %tu3%, toons.ini, toon%ToonIndex%, tu3
	IniWrite, %tu4%, toons.ini, toon%ToonIndex%, tu4
	IniWrite, %tu5%, toons.ini, toon%ToonIndex%, tu5
	IniWrite, %tu6%, toons.ini, toon%ToonIndex%, tu6
	IniWrite, %tr1%, toons.ini, toon%ToonIndex%, tr1
	IniWrite, %tr2%, toons.ini, toon%ToonIndex%, tr2
	IniWrite, %tr3%, toons.ini, toon%ToonIndex%, tr3
	IniWrite, %tr4%, toons.ini, toon%ToonIndex%, tr4
	IniWrite, %tr5%, toons.ini, toon%ToonIndex%, tr5
	IniWrite, %tr6%, toons.ini, toon%ToonIndex%, tr6
	IniWrite, %lu1%, toons.ini, toon%ToonIndex%, lu1
	IniWrite, %lu2%, toons.ini, toon%ToonIndex%, lu2
	IniWrite, %lu3%, toons.ini, toon%ToonIndex%, lu3
	IniWrite, %lu4%, toons.ini, toon%ToonIndex%, lu4
	IniWrite, %lu5%, toons.ini, toon%ToonIndex%, lu5
	IniWrite, %lu6%, toons.ini, toon%ToonIndex%, lu6
	IniWrite, %so1%, toons.ini, toon%ToonIndex%, so1
	IniWrite, %so2%, toons.ini, toon%ToonIndex%, so2
	IniWrite, %so3%, toons.ini, toon%ToonIndex%, so3
	IniWrite, %so4%, toons.ini, toon%ToonIndex%, so4
	IniWrite, %so5%, toons.ini, toon%ToonIndex%, so5
	IniWrite, %so6%, toons.ini, toon%ToonIndex%, so6
	IniWrite, %th1%, toons.ini, toon%ToonIndex%, th1
	IniWrite, %th2%, toons.ini, toon%ToonIndex%, th2
	IniWrite, %th3%, toons.ini, toon%ToonIndex%, th3
	IniWrite, %th4%, toons.ini, toon%ToonIndex%, th4
	IniWrite, %th5%, toons.ini, toon%ToonIndex%, th5
	IniWrite, %th6%, toons.ini, toon%ToonIndex%, th6
	IniWrite, %sq1%, toons.ini, toon%ToonIndex%, sq1
	IniWrite, %sq2%, toons.ini, toon%ToonIndex%, sq2
	IniWrite, %sq3%, toons.ini, toon%ToonIndex%, sq3
	IniWrite, %sq4%, toons.ini, toon%ToonIndex%, sq4
	IniWrite, %sq5%, toons.ini, toon%ToonIndex%, sq5
	IniWrite, %sq6%, toons.ini, toon%ToonIndex%, sq6
	IniWrite, %dr1%, toons.ini, toon%ToonIndex%, dr1
	IniWrite, %dr2%, toons.ini, toon%ToonIndex%, dr2
	IniWrite, %dr3%, toons.ini, toon%ToonIndex%, dr3
	IniWrite, %dr4%, toons.ini, toon%ToonIndex%, dr4
	IniWrite, %dr5%, toons.ini, toon%ToonIndex%, dr5
	IniWrite, %dr6%, toons.ini, toon%ToonIndex%, dr6
}

;Click beans arrow for given index
ClickBeans(ToonIndex) {
	SetMouseDelay, 10
	this_id := toonid[ToonIndex]
	ControlClick, x320 y360, ahk_id %this_id%,,,200
	;MsgBox % "Bean index: " . BeanIndex . " Toonid: " . toonid[BeanIndex]
	;Click ok
	Sleep 50
	ControlClick, x382 y448, ahk_id %this_id%,,,1
}

;GoHome on a certain index
GoHome(ToonIndex) {
	;GuiControlGet, HomeIndex
	SetMouseDelay, 10
	this_id := toonid[ToonIndex]
	;600, 590 book location
	ControlClick, x600 y590, ahk_id %this_id%,,,1
	;wait 1s
	Sleep 1500
	;click the map button 615 131
	ControlClick, x615 y131, ahk_id %this_id%,,,1
	Sleep 500
	;360, 490 home button
	ControlClick, x360 y490, ahk_id %this_id%,,,1
	;MsgBox % "Bean index: " . BeanIndex . " Toonid: " . toonid[BeanIndex]
}

;GoHome on a certain index
GoPlayground(ToonIndex) {
	;GuiControlGet, HomeIndex
	SetMouseDelay, 10
	this_id := toonid[ToonIndex]
	;600, 590 book location
	ControlClick, x600 y590, ahk_id %this_id%,,,1
	;wait 1s
	Sleep 1500
	;click the map button 615 131
	ControlClick, x615 y131, ahk_id %this_id%,,,1
	Sleep 500
	;360, 490 home button
	ControlClick, x500 y490, ahk_id %this_id%,,,1
	;MsgBox % "Bean index: " . BeanIndex . " Toonid: " . toonid[BeanIndex]
}

;Set the window positions and indexes
SetWindows(){
	Loop, %toonlist%
	{
		this_id := toonlist%A_Index%
		WinActivate, ahk_id %this_id%
		;display the input box in middle of active window
		WinGetPos, curx, cury, curw, curh, ahk_id %this_id%
		;Enter the index for character in following grid:
		;[1,2,5,6]
		;[3,4,7,8]
		InputBox, UserIndex, Char Index, Enter Char Index, , 100,100,curx+(curw / 2), cury + (curh / 2)
		if ErrorLevel {
			MsgBox, CANCEL was pressed.
			break
		}

		else
			toonid[UserIndex] := this_id
			IniWrite, %this_id%, toons.ini, main, %UserIndex%
			if (UserIndex <= 2)
			{
				offset := UserIndex - 1
				xpos := offset * (screenwidth/4)
				WinMove, ahk_id %this_id%,, xpos, 0, (screenwidth/4), (screenwidth/4)  
			}
			else if (UserIndex > 2 and UserIndex <= 4)
			{
				offset := UserIndex - 3
				xpos := offset * (screenwidth/4)
				WinMove, ahk_id %this_id%,, xpos, (screenwidth/4), (screenwidth/4), (screenwidth/4)  
			}
			else if (UserIndex >4 and UserIndex <= 6)
			{
				offset := UserIndex - 3
				xpos := offset * (screenwidth/4)
				WinMove, ahk_id %this_id%,, xpos, 0, (screenwidth/4), (screenwidth/4)  
			}
			else if (UserIndex > 6 and UserIndex <= 8)
			{
				offset := UserIndex - 5
				xpos := offset * (screenwidth/4)
				WinMove, ahk_id %this_id%,, xpos, (screenwidth/4), (screenwidth/4), (screenwidth/4)  
			}
	}
}

;https://www.autohotkey.com/board/topic/85949-creating-rows-in-a-gui-solved/
GetButtonDefaultHeight() {
	Static Btn
	Gui, Add, Button, vBtn, Dummy
	GuiControlGet, Btn, Pos
	Gui, Destroy
	Return BtnH
}
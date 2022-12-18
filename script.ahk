#SingleInstance, Force
; #MaxThreadsPerHotkey 2
; Variables
; --------------------

numOfWowProcceses := getNumOfWoWs()
global renamedWoWs := []

; GUI
; --------------------
Gui, +AlwaysOnTop
Gui, Add, Text, x5 y15 vProccessesText, WoW Processes Found: %numOfWowProcceses%
Gui, Show, w300 h200, WoW AutoClicker
Gui, Add, Button, x150 y5 w70 h30 gSelect_Proc, Refresh
Gui, Add, Button, x220 y5 w70 h30 gRename_Proc, Rename
return

; Gui, Add, Button, x150 y150 w200 h30 gOur_First_Button, Press Me!

; LABELS
; --------------------

Select_Proc:
  restoreNames()
  amount := getNumOfWoWs()
  GuiControl,, ProccessesText, WoW Processes Found: %amount%
return

Rename_Proc:
  renameWoWs()
  length:= renamedWoWs.MaxIndex()
  msgbox %length%

return

GuiClose:
ExitApp
return

; FUNCTIONS
; --------------------

getNumOfWoWs() {
  WinGet, wowid, list, World of Warcraft
  numberOfWows := 0
  loop, %wowid% {
    numberOfWows++
  }

return numberOfWows
}

renameWoWs() {
  WinGet, wowid, list, World of Warcraft
  renamedWoWs := []
  Loop, %wowid% {
    newName:= "WoW" . A_Index
    this_id := wowid%A_Index%
    ; push to double array
    renamedWoWs.Push([%this_id%,%newName%])

    WinSetTitle, ahk_id %this_id%,, %newName%
  }
}

restoreNames() {
  SetTitleMatchMode, regex
  WinGet, wowid, list, WoW\d
  Loop, %wowid% {
    this_id := wowid%A_Index%
    WinSetTitle, ahk_id %this_id%,, World of Warcraft
  }
  renamedWoWs := []
}

; HOTKEYS
; --------------------

^x::ExitApp

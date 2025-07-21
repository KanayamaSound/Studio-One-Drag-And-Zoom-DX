; === Studio One Drag and Zoom DX - Forked From Ronner's Studio One Drag and Zoom - https://github.com/Ronner/Studio-One-Drag-And-Zoom ===

Persistent
#SingleInstance Force
SetTitleMatchMode("RegEx")
kShift := 0x4
kCtrl := 0x8
kCtrlShift := 0xc
kNone := 0x0
A_IconTip := "Studio One Drag and Zoom DX"
A_AllowMainWindow := 0
regName := "Studio One Drag and Zoom DX"
regPath := "HKEY_CURRENT_USER\Software\" . regName
runRegPath := "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
dragSensX := RegRead(regPath, "dragSensX", 4)
dragSensY := RegRead(regPath, "dragSensY", 4)
runOnStartup := RegRead(regPath, "runOnStartup", true)
dragEnabled := RegRead(regPath, "dragEnabled", true)
switchMouseButtons := RegRead(regPath, "switchMouseButtons", false)
mwZoomEnabled := RegRead(regPath, "mwZoomEnabled", true)
DragZoomEnabled := RegRead(regPath, "DragZoomEnabled", false)
DragZoomKeyOpt := RegRead(regPath, "DragZoomKeyOpt", 1)
mwZoomSens := RegRead(regPath, "mwZoomSens", 100)
DragZoomSens := RegRead(regPath, "DragZoomSens", 40)


sensOptions := ["Slowest", "Slower", "Slow", "Default", "Fast", "Faster", "Fastest"]
mwZoomSensValues := [10, 20, 35, 50, 80, 100, 150]
DragZoomSensValues := [70, 60, 50, 40, 30, 20, 10]
DragZoomKeys := ["Ctrl+Win+ Left>Horiz/Right>Vert", "Ctrl+Win+Left>Horiz/Alt+Win+Left>Vert", "Ctrl+Win+Left>Both"]
DragZoomKeyValues := [1, 2, 3]

DragSensXSubmenu := Menu()
DragSensYSubmenu := Menu()
ZoomSensSubmenu := Menu()
DZoomKeysSubmenu := Menu()
DZoomSensSubmenu := Menu()

Loop sensOptions.Length {
	DragSensXSubmenu.Add(sensOptions[A_Index], SensitivityMenuItemHandler)
	DragSensYSubmenu.Add(sensOptions[A_Index], SensitivityMenuItemHandler)
	ZoomSensSubmenu.Add(sensOptions[A_Index], SensitivityMenuItemHandler)
	DZoomSensSubmenu.Add(sensOptions[A_Index], SensitivityMenuItemHandler)
	
}
Loop DragZoomKeys.Length {
		DZoomKeysSubmenu.Add(DragZoomKeys[A_Index], SensitivityMenuItemHandler)

}


runOnStartupText := "Run on Startup"
dragEnabledText := "Drag Scroll Enabled"
mwZoomEnabledText := "Zoom Enabled"
DragZoomEnabledText := "Drag Zoom"
switchMouseButtonsText := "Horizontal Only on Left Mouse Button"

A_TrayMenu.Delete()
A_TrayMenu.Add(runOnStartupText, ToggleSetting)
A_TrayMenu.Add()
A_TrayMenu.Add(dragEnabledText, ToggleSetting)
A_TrayMenu.Add("Drag sensitivity X", DragSensXSubmenu)
A_TrayMenu.Add("Drag sensitivity Y", DragSensYSubmenu)
A_TrayMenu.Add(switchMouseButtonsText, ToggleSetting)
A_TrayMenu.Add()
A_TrayMenu.Add(mwZoomEnabledText, ToggleSetting)
A_TrayMenu.Add("Zoom Sensitivity", ZoomSensSubmenu)
A_TrayMenu.Add(DragZoomEnabledText, ToggleSetting)
A_TrayMenu.Add("Drag Zoom Sensitivity", DZoomSensSubmenu)
A_TrayMenu.Add("Drag Zoom Keys", DZoomKeysSubmenu)
A_TrayMenu.Add()
A_TrayMenu.Add("Exit", (*) => ExitApp())

if FileExist(A_WorkingDir . "\s1+mouse.ico")
	TraySetIcon(A_WorkingDir . "\s1+mouse.ico")

SaveSettings()

ToggleSetting(menuItem, *) {
	global runOnStartup, dragEnabled, mwZoomEnabled, DragZoomEnabled, switchMouseButtons

	If (menuItem = runOnStartupText)
		runOnStartup := !runOnStartup

	If (menuItem = dragEnabledText)
		dragEnabled := !dragEnabled

	If (menuItem = mwZoomEnabledText)
		mwZoomEnabled := !mwZoomEnabled

	If (menuItem = DragZoomEnabledText)
		DragZoomEnabled := !DragZoomEnabled

	If (menuItem = switchMouseButtonsText)
		switchMouseButtons := !switchMouseButtons

	SaveSettings()
}

SensitivityMenuItemHandler(Item, ItemPos, TheMenu) {
	global dragSensX, dragSensY, mwZoomSens, DragZoomSens, DragZoomKeyOpt
	dragSensX := (TheMenu = DragSensXSubmenu) ? ItemPos : dragSensX
	dragSensY := (TheMenu = DragSensYSubmenu) ? ItemPos : dragSensY
	mwZoomSens := (TheMenu = ZoomSensSubmenu) ? mwZoomSensValues[ItemPos] : mwZoomSens
	SaveSettings()
	DragZoomKeyOpt:= (TheMenu = DZoomKeysSubmenu) ? DragZoomKeyValues[ItemPos] : DragZoomKeyOpt
	SaveSettings()
	DragZoomSens := (TheMenu = DZoomSensSubmenu) ? DragZoomSensValues[ItemPos] : DragZoomSens
	SaveSettings()


}

SaveSettings() {
	RegWrite(runOnStartup, "REG_DWORD", regPath, "runOnStartup")
	RegWrite(dragSensX, "REG_DWORD", regPath, "dragSensX")
	RegWrite(dragSensY, "REG_DWORD", regPath, "dragSensY")
	RegWrite(dragEnabled, "REG_DWORD", regPath, "dragEnabled")
	RegWrite(switchMouseButtons, "REG_DWORD", regPath, "switchMouseButtons")
	RegWrite(mwZoomEnabled, "REG_DWORD", regPath, "mwZoomEnabled")
	RegWrite(DragZoomEnabled, "REG_DWORD", regPath, "DragZoomEnabled")
	RegWrite(mwZoomSens, "REG_DWORD", regPath, "mwZoomSens")
            RegWrite(DragZoomKeyOpt, "REG_DWORD", regPath, "DragZoomKeyOpt")
	RegWrite(DragZoomSens, "REG_DWORD", regPath, "DragZoomSens")


	If (runOnStartup)
		RegWrite(A_ScriptFullPath, "REG_SZ", runRegPath, regName)
	Else
		Try RegDelete(runRegPath, regName)

	UpdateMenuState()
}

UpdateMenuState() {
	If (runOnStartup)
		A_TrayMenu.Check(runOnStartupText)
	Else
		A_TrayMenu.Uncheck(runOnStartupText)
            If (switchMouseButtons){
		A_TrayMenu.Check(switchMouseButtonsText)
            }
	Else{
		A_TrayMenu.Uncheck(switchMouseButtonsText)
	}

	If (dragEnabled) {
		A_TrayMenu.Check(dragEnabledText)
		A_TrayMenu.Enable("Drag sensitivity X")
		A_TrayMenu.Enable("Drag sensitivity Y")
	}
	Else {
		A_TrayMenu.Uncheck(dragEnabledText)
		A_TrayMenu.Disable("Drag sensitivity X")
		A_TrayMenu.Disable("Drag sensitivity Y")
	}

	If (mwZoomEnabled) {
		A_TrayMenu.Check(mwZoomEnabledText)
		A_TrayMenu.Enable("Zoom Sensitivity")
                                A_TrayMenu.Enable(DragZoomEnabledText)
	}
	Else {
		A_TrayMenu.Uncheck(mwZoomEnabledText)
		A_TrayMenu.Disable("Zoom Sensitivity")
                        A_TrayMenu.Disable(DragZoomEnabledText)
		A_TrayMenu.Disable("Drag Zoom Keys")

	}
	If (DragZoomEnabled) {
		A_TrayMenu.Check(DragZoomEnabledText)
		A_TrayMenu.Enable("Drag Zoom Keys")
		A_TrayMenu.Enable("Drag Zoom Sensitivity")
	}
	Else {
		A_TrayMenu.Uncheck(DragZoomEnabledText)
		A_TrayMenu.Disable("Drag Zoom Keys")
		A_TrayMenu.Disable("Drag Zoom Sensitivity")

	}


	Loop sensOptions.Length {
		DragSensXSubmenu.Uncheck(sensOptions[A_Index])
		DragSensYSubmenu.Uncheck(sensOptions[A_Index])
		ZoomSensSubmenu.Uncheck(sensOptions[A_Index])
		DZoomSensSubmenu.Uncheck(sensOptions[A_Index])
	}
            Loop DragZoomKeys.Length {
                        DZoomKeysSubmenu.Uncheck(DragZoomKeys[A_Index])
	}


	DragSensXSubmenu.Check(sensOptions[dragSensX])
	DragSensYSubmenu.Check(sensOptions[dragSensY])

	For i, v in mwZoomSensValues {
		if (v = mwZoomSens)
			ZoomSensSubmenu.Check(sensOptions[i])
	}
	For i, v in DragZoomKeyValues {
		if (v = DragZoomKeyOpt)
			DZoomKeysSubmenu.Check(DragZoomKeys[i])
	}
	For i, v in DragZoomSensValues {
		if (v = DragZoomSens)
			DZoomSensSubmenu.Check(sensOptions[i])
	}

}

CheckWin() {
	MouseGetPos(, , &wnd)
	exe := WinGetProcessName("ahk_id " wnd)
	Return (StrLower(exe) = "studio one.exe")
}

HandleDragButton(ignoreY) {

	global lastX, lastY, startX, startY, ignoreYEnabled
	ignoreYEnabled := ignoreY
	MouseGetPos(&startX, &startY)
	lastX := startX
	lastY := startY
	SetTimer(Timer, 10)
}

ReleaseDragButton() {
	SetTimer(Timer, 0)
}

HandleMouseWheel(delta) {
	MouseGetPos(&mX, &mY)
	PostMW(delta, kCtrl, mX, mY)
	PostMW(delta, kCtrlShift, mX, mY)
}

PostMW(delta, modifiers, x, y) {
	CoordMode("Mouse", "Screen")
	MouseGetPos(, , &currentWindow)
	lowOrderX := x & 0xFFFF
	highOrderY := y & 0xFFFF
	PostMessage(0x20A, delta << 16 | modifiers, highOrderY << 16 | lowOrderX, , "ahk_id " currentWindow)
}

Timer() {
	global lastX, lastY
	MouseGetPos(&curX, &curY)
	dX := (curX - lastX)
	dY := (curY - lastY)
	scrollX := dX * dragSensX
	scrollY := dY * dragSensY

	If (dX != 0) {
		PostMW(scrollX, kShift, startX, startY)
	}

	If (dY != 0 && !ignoreYEnabled) {
	 	PostMW(scrollY, kNone, startX, startY)
	}

	lastX := curX
	lastY := curY
}

; === Drag Zoom Init Values ===
	zoomStartX := 0
	zoomStartY := 0
	zoomDirection := ""
	driftBuffer := 300  ; pixels


#HotIf CheckWin() and DragZoomEnabled and mwZoomEnabled

; === Prevent Windows Key from Opening Start Menu ===
	~Lwin::send "{blind}{vkE8}"

; === Handle Selected Drag Zoom Keys ===

^#LButton::
	{
        global zoomDirection, DragZoomKeyOpt
   	MouseGetPos(&zoomStartX, &zoomStartY)
	If DragZoomKeyOpt = 3{
	zoomDirection := "Both"
        }
        Else{
        zoomDirection := "Horizontal"
        }
    	SetTimer(ZoomDragCheck, 10)
	Return
	}

^#RButton::
	{
        global zoomDirection, DragZoomKeyOpt
        If DragZoomKeyOpt = !1{
        Return
        }
   	MouseGetPos(&zoomStartX, &zoomStartY)
   	zoomDirection := "Vertical"
    	SetTimer(ZoomDragCheck, 10)
	Return
	}
!#LButton::
	{
        global zoomDirection, DragZoomKeyOpt
        If DragZoomKeyOpt = !2{
        Return
        }
   	MouseGetPos(&zoomStartX, &zoomStartY)
   	zoomDirection := "Vertical"
    	SetTimer(ZoomDragCheck, 10)
	Return
	}

!^#LButton::
	{
        global zoomDirection, DragZoomKeyOpt
        If DragZoomKeyOpt = 2{
   	MouseGetPos(&zoomStartX, &zoomStartY)
   	zoomDirection := "Both"
    	SetTimer(ZoomDragCheck, 10)
	Return
	}
^#LButton Up::
	{
        global zoomDirection
   	SetTimer(ZoomDragCheck, 0)
    	zoomDirection := ""
    	Return
	}
!^#LButton Up::
	{
        global zoomDirection
   	SetTimer(ZoomDragCheck, 0)
    	zoomDirection := ""
    	Return
	}

^#RButton Up::
	{
        global zoomDirection
   	SetTimer(ZoomDragCheck, 0)
    	zoomDirection := ""
    	Return
	}
!#LButton Up::
	{
        global zoomDirection
   	SetTimer(ZoomDragCheck, 0)
    	zoomDirection := ""
    	Return
	}


#HotIf

ZoomDragCheck()
{

    global zoomStartX, zoomStartY, zoomDirection, DragZoomSens

    MouseGetPos(&curX, &curY)
    deltaX := curX - zoomStartX
    deltaY := curY - zoomStartY

    ; Vertical Drag Zoom
        if (Abs(deltaY) > DragZoomSens and Abs(deltaX) <= driftBuffer and (zoomDirection = "Vertical" or zoomDirection = "Both")) {
        
        if (deltaY < 0)
            Send("^!{Down}")  ; Zoom In
        else
            Send("^!{Up}")  ; Zoom Out
        zoomStartX := curX
        zoomStartY := curY
        return
    }

    ; Horizontal Drag Zoom
        if (Abs(deltaX) > DragZoomSens and (zoomDirection = "Horizontal" or zoomDirection = "Both")) {
        if (deltaX > 0)
            Send("^!{Right}")  ; Horizontal Zoom In
        else
            Send("^!{Left}")  ; Horizontal Zoom Out
        zoomStartX := curX
        zoomStartY := curY
        return
    }
}

#HotIf CheckWin() and dragEnabled
#LButton::HandleDragButton(switchMouseButtons)
#RButton::HandleDragButton(!switchMouseButtons)
#LButton Up::ReleaseDragButton()
#RButton Up::ReleaseDragButton()
#HotIf

#HotIf CheckWin() and mwZoomEnabled and !DragZoomEnabled
#WheelDown::HandleMouseWheel(-mwZoomSens)
#WheelUp::HandleMouseWheel(mwZoomSens)
#HotIf


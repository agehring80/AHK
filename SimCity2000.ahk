; 1. Run SimCity2000 maximized
; 2. Crtl+Space hides the Taskbar
; 3. Zoom in and out with the mouse wheel

WindowID := ""
WindowState := 0
ErrorLevel := ProcessExist("simcity.exe")
if (errorlevel = 0)
{
	Run("simcity.exe")
	ErrorLevel := !WinWait("SimCity")
	WinMaximize()
}

Loop
{
  ErrorLevel := ProcessExist("simcity.exe")
  if (errorlevel = 0)
  {
    try
    {
      WinShow("ahk_class Shell_TrayWnd")
    }
    ExitApp()
  }
  Sleep(10000)
}

#HotIf WinActive("ahk_exe simcity.exe",)

WheelUp::
{
  WinShow("ahk_class AfxControlBar")
  WinGetPos(, , &W, &H, "ahk_class AfxControlBar")
  ratio := H / W
  if ratio >= 4.08 && ratio <= 4.1
  {
	XP := Floor(W / 2)
	YP := Floor(H / 10 * 6)
	ControlClick("x" XP " y" YP, "ahk_class AfxControlBar")
  }
  else if ratio >= 5.9 && ratio <= 6
  {
	XP := Floor(W / 1.5)
	YP := Floor(H / 4 * 3)
	ControlClick("x" XP " y" YP, "ahk_class AfxControlBar")
  }
  RETURN
}

WheelDown::
{
  WinShow("ahk_class AfxControlBar")
  WinGetPos(, , &W, &H, "ahk_class AfxControlBar")
  ratio := H / W
  if ratio >= 4.08 && ratio <= 4.1
  {
	XP := Floor(W / 3)
	YP := Floor(H / 10 * 6)
	ControlClick("x" XP " y" YP, "ahk_class AfxControlBar")
  }
  else if ratio >= 5.9 && ratio <= 6
  {
	XP := Floor(W / 3)
	YP := Floor(H / 4 * 3)
	ControlClick("x" XP " y" YP, "ahk_class AfxControlBar")
  }
  RETURN
}

^Space::
{
  global WindowID
  global WindowState
  TempWindowID := WinGetID("SimCity")
  If (WindowID != TempWindowID)
  {
    WindowID := TempWindowID
    WindowState := 0
  }
  If (WindowState != 1)
  {
    try
    {
      WinMove(0, 0, A_ScreenWidth, A_ScreenHeight, "ahk_id " WindowID)
      WinHide("ahk_class Shell_TrayWnd")
	  WinMove(5, A_ScreenHeight / 13, , , "ahk_class AfxControlBar")
      WinSetAlwaysOnTop(1, "ahk_class AfxControlBar")
    }
  }
  Else
  {
    try
    {
      WinShow("ahk_class Shell_TrayWnd")
	  WinSetAlwaysOnTop(0, "ahk_class AfxControlBar")
    }
  }
  WindowState := !WindowState
  return
}
#HotIf

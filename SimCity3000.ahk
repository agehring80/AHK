; 1. Run SimCity3000
; 2. Zoom in and out with the mouse wheel

ErrorLevel := ProcessExist("SC3U.exe")
if (errorlevel = 0)
{
	Run("SC3U.exe")
	ErrorLevel := !WinWait("SimCity 3000")
}

Loop
{
  ErrorLevel := ProcessExist("SC3U.exe")
  if (errorlevel = 0)
  {
    ExitApp()
  }
  Sleep(10000)
}

#HotIf WinActive("ahk_exe SC3U.exe")
WheelUp::Send "{NumpadAdd}"
WheelDown::Send "{NumpadSub}"
#HotIf

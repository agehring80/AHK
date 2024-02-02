#MaxThreadsPerHotkey 2
Persistent
SetNumLockState("AlwaysOn")

; CapsLock is remapped (in WinRegistry) to F17 with the tool SharpKeys !

#HotIf GetKeyState("F17", "P") ; For all following functions CapsLock is necessary as activator
Space:: SetCapsLockState(!GetKeyState("CapsLock", "T")) ; Toggle the real CapsLockState with CapslockKey + Space
; write german (annoying) umlauts when US layout is used with any keyboard
a:: Send("ä")
o:: Send("ö")
u:: Send("ü")
e:: Send("€")
+a:: Send("Ä")
+o:: Send("Ö")
+u:: Send("Ü")

; write german (annoying) umlauts when US layout is used with an german keyboard (keys above also working)
':: Send("ä")      ;easier on german layout
SC027:: Send("ö")      ;easier on german layout
[:: Send("ü")      ;easier on german layout
s:: Send("ß")      ;CapsLock+s = CapsLock+s, Eszett
+':: Send("Ä")     ;easier on german layout
+SC027:: Send("Ö")     ;easier on german layout
+[:: Send("Ü")     ;easier on german layout
-:: Send("ß")      ;easier on german layout

;for keyboards with missing Pause key
p:: Send("{Pause}")

; use the program spyxx to find a windows control message, then you can assign shortcuts to it.
; Example:
; +t::
; PostMessage, 0x0111, 0x00001303, 0x00000000,,DOSBox-X ; Turbo
; RETURN

; always useful
Right:: Send("{Volume_Up}")
Left:: Send("{Volume_Down}")

^t::
{
  CurrentDateTime := FormatTime(, "dd.MM.yyyy")
  SendInput(CurrentDateTime " mailaddress")
  RETURN
}

; Convert Clip to upper
^PgUp::
{
  A_Clipboard := StrUpper(A_Clipboard)
  Send(A_Clipboard)
  RETURN
}

; Convert Clip to lower
^PgDn::
{
  A_Clipboard := StrLower(A_Clipboard)
  Send(A_Clipboard)
  RETURN
}

; Reverse Clip
^r::
{
  strvar := A_Clipboard
  DllCall("msvcrt.dll\_wcsrev", "UPtr", StrPtr(strvar), "CDecl")
  Send(strvar)
  RETURN
}

; Clip to KeyboardKeys (useful on fields that prevent direct insert from Clip)
^v:: Send("{Raw}" A_Clipboard) ;

; Strikethrough Clip
^F11::
{
  str := A_Clipboard
  out := ""
  Loop strlen(str)
    out .= SubStr(str, (A_Index) < 1 ? (A_Index) - 1 : (A_Index), 1) Chr(0x336)
  Send(out)
  RETURN
}

; Column ClipBoard Insert
^F12::
{
  Send("{Down}")
  length := StrLen(A_Clipboard)
  Send("{Left " length "}")
  Send("{Raw}" A_Clipboard)
  RETURN
}

;Numpad Keyboard Mouse
SC04F:: MouseMove(-1, 1, 0, "R")  ; Numpad1 key down left
SC050:: MouseMove(0, 1, 0, "R")   ; Numpad2 key down
SC051:: MouseMove(1, 1, 0, "R")   ; Numpad3 key down right
SC04B:: MouseMove(-1, 0, 0, "R")  ; Numpad4 key left
SC04C:: Send("{LButton}")         ; Numpad5 LButton
SC053:: Send("{RButton}")         ; Numpad. RButton
SC04D:: MouseMove(1, 0, 0, "R")   ; Numpad6 key right
SC047:: MouseMove(-1, -1, 0, "R") ; Numpad7 key up left
SC048:: MouseMove(0, -1, 0, "R")  ; Numpad8 key up
SC049:: MouseMove(1, -1, 0, "R")  ; Numpad9 key up right
toggle := 0
SC052::
{
  global
  (toggle := !toggle) ? toggleon() : toggleoff()  ; Numpad0 Toggle LButton
}
toggleon()
{
  Send("{LButton Down}")
  ToolTip("Left Button Down`ris active", 20, 20, 1)
}
toggleoff()
{
  Send("{LButton Up}")
  ToolTip(, , , 1)
}
Fire := 0
LButton::
{
  global
  Send("{LButton}")
  if not KeyWait('LButton', 'T0.25')
  {
    Fire := !Fire
    While Fire
    {
      Send("{LButton}")
      Sleep(1)
    }
  }
  Fire := 0
  RETURN
}
awake := 0
^w::
{
  global
  awake := !awake
  ToolTip "Awake is " awake, 20, 20, 2
  SetTimer () => ToolTip(, , , 2), -3000
  While awake
  {
    MouseMove(1, 0, 0, "R")
    MouseMove(-1, 0, 0, "R")
    Sleep(170000)
  }
  RETURN
}
#HotIf
;make Mouse Button 4 & 5 useful
XButton2:: Send("#v")
XButton1::
{
  startTime := A_TickCount
  while GetKeyState('XButton1', 'P')
  {
    if (A_TickCount - startTime > 250)
    {
      Send("#{TAB}")
      return
    }
    Sleep(10)
  }
  Send("!{TAB}")
  RETURN
}
; Win11 Greenshot Fixes (adjust Greenshot Preferences, also!)
+PrintScreen::
{
  Send "{Shift Down}{F22}{Shift Up}" ; Capture last region
  RETURN
}
!PrintScreen::
{
  Send "{Alt Down}{F22}{Alt Up}" ; Capture window
  RETURN
}
^PrintScreen::
{
  Send "{Ctrl Down}{F22}{Ctrl Up}" ; Capture full screen
  RETURN
}
*PrintScreen:: Send "{F22}" ; Capture region

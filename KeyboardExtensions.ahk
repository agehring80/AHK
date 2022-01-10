#Persistent
SetNumLockState, AlwaysOn

; CapsLock is remapped (in WinReregistry) to F16 with the tool SharpKeys
#If, GetKeyState("F16", "P")
Space::SetCapsLockState % !GetKeyState("CapsLock", "T") ; Toggle CapsLock with CapslockKey + Space 
a::Send, ä
o::Send, ö
u::Send, ü
'::Send, ä		;easier on german layout
SC027::Send, ö		;easier on german layout
[::Send, ü		;easier on german layout
s::Send, ß		;CapsLock+s = CapsLock+s, Eszett
e::Send, €
+a::Send, Ä
+o::Send, Ö
+u::Send, Ü
+'::Send, Ä		;easier on german layout
+SC027::Send, Ö		;easier on german layout
+[::Send, Ü		;easier on german layout
-::Send, ß		;easier on german layout

Right::Send {volume_up}
Left::Send {volume_down}

^PgUp::                                ; Convert Clip to upper
 StringUpper Clipboard, Clipboard
 Send %Clipboard%
RETURN

^PgDn::                                ; Convert Clip to lower
 StringLower Clipboard, Clipboard
 Send %Clipboard%
RETURN

^v::SendRaw %clipboard%


;Numpad Keyboard Mouse
SC04F::MouseMove, -1, 1, 0, R  ; Numpad1 key down left
SC050::MouseMove, 0, 1, 0, R   ; Numpad2 key down
SC051::MouseMove, 1, 1, 0, R   ; Numpad3 key down right
SC04B::MouseMove, -1, 0, 0, R  ; Numpad4 key left
SC04C::Send {LButton}          ; Numpad5 LButton
SC053::Send {RButton}          ; Numpad. RButton
SC04D::MouseMove, 1, 0, 0, R   ; Numpad6 key right
SC047::MouseMove, -1, -1, 0, R ; Numpad7 key up left
SC048::MouseMove, 0, -1, 0, R  ; Numpad8 key up
SC049::MouseMove, 1, -1, 0, R  ; Numpad9 key up right
SC052::% (toggle := !toggle) ? toggleon() : toggleoff()  ; Numpad0 Toggle LButton
toggleon()
  {
	  Hotkey, NumpadEnter, on
	  Send {LButton Down}
	  Tooltip, Left Button Down`rNumpadEnter to cancel, 20,20
	}

toggleoff()
	{	   
	  Hotkey, NumpadEnter, off
	  Send {LButton Up}
	  Tooltip
	}
#If

NumpadEnter::   ; Escape Hotkey
  Tooltip              ; turn Tooltip off
  toggle = 0           ; set toogle to off
  Send {LButton Up}    ; release LButton
  Hotkey, NumpadEnter, off
Return

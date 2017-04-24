; Description: Autohotkey script used for Chrome Remote Desktop
; and Everquest. It should be generally portable with any Chrome
; remote desktop app.
; VERSION: 1.0.1
; Author: @Elebertus


; This is used so we can match "Chrome Remote Desktop"
; in the `WinGetTitle` call.
SetTitleMatchMode RegEx 
; This can likely be disabled, but I've found that if
; you have another window over your screen its buggy.
DetectHiddenWindows, On
; My current CRD test is titled "eqbox1 - Chrome Remote Desktop"
; so keying off the generic "Chrome Remote Desktop"
; string allows flexibility. I'm not actually sure what
; happens if you have multiple windows..
WinGetTitle, crdWinTitle, Chrome Remote Desktop

; TODO: Registering the hotkey with the control object
; should be a function. I would like to be able to
; configure an array, or map of hotkeys and actions
; that we loop through and register as custom hotkeys.
; Otherwise you need to copy and paste this block for 
; each hotkey manually.

; The hotkey declaration. The "^" represents the ctrl key
; the syntax list is here: https://autohotkey.com/docs/Hotkeys.htm#Symbols
; e.g.: 
; !1:: == alt+1
; +1:: == shift+1
; ^1 & +2 == ctrl+1, shift+2
; the '<' and '>' brackets will indicate left/right meta keys 
; <+1:: == leftShif+1

^1::
; Check to make sure the window exists before sending
IfWinExist, %crdWinTitle%
{
    ; Introduces a delay for the key to be pressed and how long
    ; the key is pressed for. You may need to tinker with
    ; these values if you're seeing odd behavior.
    SetKeyDelay, 20, 20
    ; `Chrome_RenderWidgetHostHWND1` is the control object.
    ; It should be static. ControlFocus focuses input
    ; on the control object's window. I wasn't able to
    ; get CRD to work without this.
    ControlFocus,Chrome_RenderWidgetHostHWND1,%crdWinTitle%
    ; ControlSend: Control Object Name, The key to send, Title of window
    ; The only value you should need to change is the key to send
    ; or in this case "1". I believe you can even send
    ; complex things like /doability 1 and such. You
    ; will have to play with this.
    ControlSend,Chrome_RenderWidgetHostHWND1,1,%crdWinTitle%
}
return

; For easier copy-pasting:
; change YOUR_HOTKEY_TO_PRESS to the keybinding you want to use
; change YOUR_ACTION_FROM_HOTKEY_TO_PRESS to the action you want

;  YOUR_HOTKEY_TO_PRESS::
;  IfWinExist, %crdWinTitle%
;  {
;      SetKeyDelay, 20, 20
;      ControlFocus,Chrome_RenderWidgetHostHWND1,%crdWinTitle%
;      ControlSend,Chrome_RenderWidgetHostHWND1,YOUR_ACTION_FROM_HOTKEY_TO_PRESS,%crdWinTitle%
;  }

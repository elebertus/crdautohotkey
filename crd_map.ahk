#SingleInstance on
SetTitleMatchMode RegEx 
DetectHiddenWindows, On
WinGetTitle, crdWinTitle, Chrome Remote Desktop
SetKeyDelay, 20, 20

; This maps ctrl+1-9 to 1-9 on the target CRD window
; as well as ctrl+NumPad1-8 to alt+1-8 on the target
; CRD window. This is a pretty basic layout, should 
; be able to cast all memmed spells and have a pretty
; good mapping to basic hotkeys and macros as well.
;
; You can change this to anything you like by replacing
; the key/value pairs in the EQHotKeys associative array.
EQHotKeys := {"^1": "1", "^2": "2", "^3": "3", "^4": "4", "^5": "5", "^6": "6", "^7": "7", "^8": "8", "^9": "9", "^NumPad1": "!1", "^NumPad2": "!2", "^NumPad3": "!3", "^Numpad4": "!4", "^NumPad5": "!5", "^NumPad6": "!6", "^NumPad7": "!7", "^NumPad8": "!8"}

; I can't really explain this logic very well.
; My understanding is that you can't push a
; variable into a lable, so  we need to use
; a BoundFunc object so we can pass the params
; Way better explained in this post
; https://autohotkey.com/boards/viewtopic.php?t=31140
for key, mapping in EQHotKeys {
	fn := Func("SendKey").Bind(mapping)
	hotkey, % key, % fn
}

SendKey(keySent){
	global crdWinTitle
    ControlFocus,Chrome_RenderWidgetHostHWND1,%crdWinTitle%
    ControlSend,Chrome_RenderWidgetHostHWND1,%keySent%,%crdWinTitle%
}
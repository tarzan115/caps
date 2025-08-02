caps/caps_qwerty.ahk
#Requires AutoHotkey v2.0

; QWERTY-friendly version of caps.ahk
; Supercharge your CapsLock: lightning-fast navigation, selection, and app switching with one key.
; Designed for QWERTY layout.

SetCapsLockState "AlwaysOff"

global appCycle := Map()
global lastKey := ""
global visualMode := false
global keyBuffer := ""
global bufferTimer := 0
global capsFHeld := false   ; Tracks if CapsLock+f is held

CapsLock::
{
    ErrorLevel := 0
    KeyWait("CapsLock", "T0.1")
    if !ErrorLevel {
        TurnOffVisualMode()
        Send("{Backspace}")
    }
}
return

; Toggle Visual Mode with CapsLock + v (auto-off after 1000000ms, matches Colemak)
CapsLock & v:: {
    global visualMode
    visualMode := !visualMode
    ToolTip visualMode ? "Visual Mode ON" : "Visual Mode OFF"
    SetTimer(() => ToolTip(), -1000) ; Hide tooltip after 1 second

    if (visualMode) {
        SetTimer(TurnOffVisualMode, -1000000) ; Turn off after 1000000ms (effectively disables auto-off)
    }
}

TurnOffVisualMode() {
    global visualMode
    visualMode := false
    ToolTip("Visual Mode auto OFF")
    SetTimer(() => ToolTip(), -1000)
}

; Navigation keys with optional Shift for selection
; QWERTY: j = left, l = right, i = up, k = down
CapsLock & j:: {
    global visualMode
    Send(visualMode ? "+{Left}" : "{Left}")
}
CapsLock & l:: {
    global visualMode
    Send(visualMode ? "+{Right}" : "{Right}")
}
CapsLock & i:: {
    global visualMode, capsFHeld
    if capsFHeld {
        Move5("Up", visualMode)
    } else {
        Send(visualMode ? "+{Up}" : "{Up}")
    }
}
CapsLock & k:: {
    global visualMode, capsFHeld
    if capsFHeld {
        Move5("Down", visualMode)
    } else {
        Send(visualMode ? "+{Down}" : "{Down}")
    }
}

; Track CapsLock+f state for 5-step navigation
CapsLock & f:: {
    global capsFHeld
    capsFHeld := true
    KeyWait("f")
    capsFHeld := false
}

Move5(key, visualMode) {
    Send(visualMode ? "+{" key " 5}" : "{" key " 5}")
}

; Copy and turn off visual mode (parity with Colemak)
CapsLock & c:: {
    TurnOffVisualMode()
    Send("^c")
}

#HotIf GetKeyState("Shift")
CapsLock & j:: Send("{WheelLeft}")
CapsLock & l:: Send("{WheelRight}")
CapsLock & i:: Send("{WheelUp}")
CapsLock & k:: Send("{WheelDown}")
#HotIf

; Next and previous word functionality with Visual Mode
; QWERTY: o = next word, u = previous word
CapsLock & o:: {
    Send(visualMode ? "+^{Right}" : "^{Right}")
}
CapsLock & u:: {
    Send(visualMode ? "+^{Left}" : "^{Left}")
}

; Home and End navigation with Visual Mode and double-tap for Ctrl+Home/End
; QWERTY: h = Home, ; = End
CapsLock & h:: {
    HandleSequence("h")
    if (keyBuffer != "hh") {
        Send(visualMode ? "+{Home}" : "{Home}")
    }
}
CapsLock & `;:: {
    HandleSequence(";")
    if (keyBuffer != ";;") {
        Send(visualMode ? "+{End}" : "{End}")
    }
}

HandleSequence(key) {
    global keyBuffer, bufferTimer
    keyBuffer .= key
    SetTimer(ClearBuffer, -500) ; Clear buffer after 500ms

    if (keyBuffer = ";;") {
        keyBuffer := ""
        Send(visualMode ? "+^{End}" : "^{End}") ; Ctrl+End
    } else if (keyBuffer = "hh") {
        keyBuffer := ""
        Send(visualMode ? "+^{Home}" : "^{Home}") ; Ctrl+Home
    }
}

ClearBuffer() {
    global keyBuffer
    keyBuffer := ""
}

; go back and go forward
CapsLock & ,:: Send("{Alt Down}{Left}{Alt Up}")
CapsLock & .:: Send("{Alt Down}{Right}{Alt Up}")

; Page Up/Down
CapsLock & p:: Send("{PgUp}")
CapsLock & n:: Send("{PgDn}")

; Delete word
CapsLock & m:: Send("{Ctrl Down}{Backspace}{Ctrl Up}")
Ctrl & CapsLock:: Send("{Ctrl Down}{Backspace}{Ctrl Up}")

; Number Row Shortcuts (QWERTY: q/w/e/a/s/d/x = 4/5/6/7/8/9/0)
CapsLock & q:: Send("{4}")
CapsLock & w:: Send("{5}")
CapsLock & e:: Send("{6}")
CapsLock & a:: Send("{7}")
CapsLock & s:: Send("{8}")
CapsLock & d:: Send("{9}")
CapsLock & x:: Send("{0}")

; Enter
CapsLock & Space:: Send("{Enter}")

; rcmd clone - App Cycling for all letters a-z
RAlt & a:: CycleApp("a")
RAlt & b:: CycleApp("b")
RAlt & c:: CycleApp("c")
RAlt & d:: CycleApp("d")
RAlt & e:: CycleApp("e", ["msedge.exe"])
RAlt & f:: CycleApp("f")
RAlt & g:: CycleApp("g")
RAlt & h:: CycleApp("h")
RAlt & i:: CycleApp("i")
RAlt & j:: CycleApp("j")
RAlt & k:: CycleApp("k")
RAlt & l:: CycleApp("l")
RAlt & m:: CycleApp("m")
RAlt & n:: CycleApp("n")
RAlt & o:: CycleApp("o")
RAlt & p:: CycleApp("p")
RAlt & q:: CycleApp("q")
RAlt & r:: CycleApp("r")
RAlt & s:: CycleApp("s")
RAlt & t:: CycleApp("t", ["ms-teams.exe", "WindowsTerminal.exe"])
RAlt & u:: CycleApp("u")
RAlt & v:: CycleApp("v")
RAlt & w:: CycleApp("w")
RAlt & x:: CycleApp("x")
RAlt & y:: CycleApp("y")
RAlt & z:: CycleApp("z")

CycleApp(letter, priorityList := []) {
    global lastKey, appCycle

    if !GetKeyState("RAlt", "P") {
        return
    }

    winList := WinGetList()
    matchList := []
    sortedList := []

    for winId in winList {
        try {
            procName := WinGetProcessName(winId)
            procNameLower := StrLower(procName)
            letterLower := StrLower(letter)

            ; Check for priority match
            isPriority := false
            for priority in priorityList {
                if procNameLower = StrLower(priority) {
                    isPriority := true
                    break
                }
            }

            if isPriority {
                sortedList.Push({ id: winId, name: procName })
            } else if SubStr(procNameLower, 1, 1) = letterLower {
                matchList.Push({ id: winId, name: procName })
            }
        } catch {
        }
    }

    for item in matchList {
        sortedList.Push(item)
    }

    if sortedList.Length = 0 {
        return
    }

    if lastKey != letter
        appCycle[letter] := 0

    idx := appCycle.Has(letter) ? appCycle[letter] : 0
    winId := sortedList[idx + 1].id
    procName := sortedList[idx + 1].name

    WinActivate(winId)

    appCycle[letter] := (idx + 1) >= sortedList.Length ? 0 : idx + 1
    lastKey := letter
}

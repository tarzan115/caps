#Requires AutoHotkey v2.0

SetCapsLockState "AlwaysOff"

global appCycle := Map()
global lastKey := ""
global visualMode := false
global keyBuffer := ""
global capsTHeld := false   ; Tracks if CapsLock+t is held

CapsLock::
{
    ErrorLevel := 0 ;
    KeyWait("CapsLock", "T0.1") ; Wait for up to 100ms to check if CapsLock is held
    if !ErrorLevel { ; If released
        TurnOffVisualMode()
        Send("{Backspace}") ; Send Backspace when clicked
    }
}
return

; Toggle Visual Mode with CapsLock + v
CapsLock & v:: {
    global visualMode
    visualMode := !visualMode
    ToolTip visualMode ? "Visual Mode ON" : "Visual Mode OFF"
    SetTimer(() => ToolTip(), -1000) ; Hide tooltip after 1 second

    if (visualMode) {
        SetTimer(TurnOffVisualMode, -1000000)
    }
}

; Copy and turn off visual mode
CapsLock & c:: {
    TurnOffVisualMode()
    Send("^c")
}

TurnOffVisualMode() {
    global visualMode
    visualMode := false
    ToolTip("Visual Mode auto OFF")
    SetTimer(() => ToolTip(), -1000)
}

; Track CapsLock+t state
CapsLock & t:: {
    global capsTHeld
    capsTHeld := true
    KeyWait("t")
    capsTHeld := false
}

; Navigation: 1 step normally, 5 steps if CapsLock+t held
CapsLock & n:: {
    global visualMode
    Send(visualMode ? "+{Left}" : "{Left}")
}
CapsLock & i:: {
    global visualMode
    Send(visualMode ? "+{Right}" : "{Right}")
}
CapsLock & u:: {
    global visualMode, capsTHeld
    if capsTHeld {
        Move5("Up", visualMode)
    } else {
        Send(visualMode ? "+{Up}" : "{Up}")
    }
}
CapsLock & e:: {
    global visualMode, capsTHeld
    if capsTHeld {
        Move5("Down", visualMode)
    } else {
        Send(visualMode ? "+{Down}" : "{Down}")
    }
}

Move5(key, visualMode) {
    Send(visualMode ? "+{" key " 5}" : "{" key " 5}")
}

; Scroll mouse
#HotIf GetKeyState("Shift") ;start of context sensitive hotkeys
CapsLock & n:: Send("{WheelLeft}")      ; Scroll left
CapsLock & i:: Send("{WheelRight}")     ; Scroll right
CapsLock & u:: Send("{WheelUp}")        ; Scroll up
CapsLock & e:: Send("{WheelDown}")      ; Scroll down
#HotIf ;end of context sensitive hotkeys

; LAlt
#HotIf GetKeyState("LAlt") ;start of context sensitive hotkeys
CapsLock & n:: Send("!{Left}")      ; Alt left
CapsLock & i:: Send("!{Right}")     ; Alt right
CapsLock & u:: Send("!{Up}")        ; Alt up
CapsLock & e:: Send("!{Down}")      ; Alt down
#HotIf ;end of context sensitive hotkeys

; Next and previous word functionality with Visual Mode
CapsLock & y:: {
    Send(visualMode ? "+^{Right}" : "^{Right}") ; Select or move to next word
}
CapsLock & l:: {
    Send(visualMode ? "+^{Left}" : "^{Left}") ; Select or move to previous word
}

; Home and End navigation with Visual Mode
CapsLock & h:: {
    HandleSequence("h")
    if (keyBuffer != "hh") {
        Send(visualMode ? "+{Home}" : "{Home}")
    }
}

CapsLock & o:: {
    HandleSequence("o")
    if (keyBuffer != "oo") {
        Send(visualMode ? "+{End}" : "{End}")
    }
}

HandleSequence(key) {
    global keyBuffer
    keyBuffer .= key
    SetTimer(ClearBuffer, -500) ; Clear buffer after 500ms

    if (keyBuffer = "oo") {
        keyBuffer := ""
        Send(visualMode ? "+^{End}" : "^{End}") ; Correct: Ctrl + End
    } else if (keyBuffer = "hh") {
        keyBuffer := ""
        Send(visualMode ? "+^{Home}" : "^{Home}") ; Correct: Ctrl + Home
    }
}

ClearBuffer() {
    global keyBuffer
    keyBuffer := ""
}

; go back and go forward
CapsLock & <:: Send("{Alt Down}{Left}{Alt Up}")
CapsLock & >:: Send("{Alt Down}{Right}{Alt Up}")

CapsLock & j:: Send("{PgUp}")
CapsLock & k:: Send("{PgDn}")
CapsLock & m:: Send("{Ctrl Down}{Backspace}{Ctrl Up}")
Ctrl & CapsLock:: Send("{Ctrl Down}{Backspace}{Ctrl Up}")

CapsLock & q:: Send("{4}")
CapsLock & w:: Send("{5}")
CapsLock & f:: Send("{6}")
CapsLock & a:: Send("{7}")
CapsLock & r:: Send("{8}")
CapsLock & s:: Send("{9}")
CapsLock & x:: Send("{0}")

CapsLock & Space:: Send("{Enter}")

; rcmd clone
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
        ; MsgBox "RAlt is not held down.", "Debug"
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
            ; MsgBox "⚠️ Failed to get process name for window ID: " . winId, "Debug"
        }
    }

    ; Append matchList to sortedList
    for item in matchList {
        sortedList.Push(item)
    }

    if sortedList.Length = 0 {
        ; MsgBox "❌ No matches found for letter: " . letter, "Debug"
        return
    }

    ; Debug: show sorted list
    debugMsg := "🔍 Sorted apps for '" . letter . "':`n"
    for item in sortedList {
        debugMsg .= item.name . "`n"
    }

    ; Reset cycle if new key is pressed
    if lastKey != letter
        appCycle[letter] := 0

    idx := appCycle.Has(letter) ? appCycle[letter] : 0
    winId := sortedList[idx + 1].id
    procName := sortedList[idx + 1].name
    debugMsg .= "`n✅ Activating: " . procName
    ; MsgBox debugMsg, "App Cycle Debug", "0x40000"

    WinActivate(winId)

    ; Update index for next cycle
    appCycle[letter] := (idx + 1) >= sortedList.Length ? 0 : idx + 1
    lastKey := letter
}

#Requires AutoHotkey v2.0

SetCapsLockState "AlwaysOff"

global appCycle := Map()
global lastKey := ""
global visualMode := false

CapsLock::
{
    ErrorLevel := 0 ;
    KeyWait("CapsLock", "T0.1") ; Wait for up to 100ms to check if CapsLock is held
    if !ErrorLevel { ; If released
        Send("{Backspace}") ; Send Backspace when clicked
    }
}
return

; Toggle Visual Mode with CapsLock + v
CapsLock & v:: {
    global visualMode
    visualMode := !visualMode
    ToolTip visualMode ? "Visual Mode ON" : "Visual Mode OFF"
    SetTimer () => ToolTip(), -1000 ; Hide tooltip after 1 second
}

; Navigation keys with optional Shift for selection
CapsLock & n:: {
    global visualMode
    Send(visualMode ? "+{Left}" : "{Left}")
}
CapsLock & i:: {
    global visualMode
    Send(visualMode ? "+{Right}" : "{Right}")
}
CapsLock & u:: {
    global visualMode
    Send(visualMode ? "+{Up}" : "{Up}")
}
CapsLock & e:: {
    global visualMode
    Send(visualMode ? "+{Down}" : "{Down}")
}

#HotIf GetKeyState("Shift") ;start of context sensitive hotkeys
CapsLock & n:: Send("{WheelLeft}")      ; Scroll left
CapsLock & i:: Send("{WheelRight}")     ; Scroll right
CapsLock & u:: Send("{WheelUp}")        ; Scroll up
CapsLock & e:: Send("{WheelDown}")      ; Scroll down
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
    Send(visualMode ? "+{Home}" : "{Home}") ; Select or move to beginning of line
}
CapsLock & o:: {
    Send(visualMode ? "+{End}" : "{End}") ; Select or move to end of line
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

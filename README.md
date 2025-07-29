# caps

> **Notice:** This project supports both Colemak and QWERTY keyboard layouts.
> [Jump to Colemak version](#colemak-version) | [Jump to QWERTY version](#qwerty-version)

Supercharge your CapsLock: lightning-fast navigation, selection, and app switching with one key.

## How to Use

### Colemak Version <a name="colemak-version"></a>

1. **Install [AutoHotkey v2](https://www.autohotkey.com/download/).**
2. Download or clone this repository.
3. Double-click `caps.ahk` to run the script, or right-click and select "Run with AutoHotkey v2".
4. The script will now remap your CapsLock key and enable all features described below.
5. To stop the script, right-click the green "H" icon in your system tray and choose "Exit".

### QWERTY Version <a name="qwerty-version"></a>

1. **Install [AutoHotkey v2](https://www.autohotkey.com/download/).**
2. Download or clone this repository.
3. Double-click `caps_qwerty.ahk` to run the script, or right-click and select "Run with AutoHotkey v2".
4. The script will now remap your CapsLock key and enable all features described below, but with QWERTY-friendly keybindings.
5. To stop the script, right-click the green "H" icon in your system tray and choose "Exit".

## Features

### Colemak Version

- **CapsLock Remapping**: CapsLock key is always off and repurposed for navigation and shortcuts.
- **Backspace Shortcut**: Tap CapsLock to send Backspace.
- **Visual Mode**: Toggle with CapsLock + v. Enables selection with navigation keys. _Automatically turns off after 10 seconds of inactivity._
- **Navigation**:
  - CapsLock + n/i/u/e: Move Left/Right/Up/Down (with selection in Visual Mode)
  - CapsLock + y/l: Move to next/previous word (with selection in Visual Mode)
  - CapsLock + h/o: Move to beginning/end of line (with selection in Visual Mode)
    - _Double-tap h or o for Ctrl+Home or Ctrl+End (with selection in Visual Mode)_
  - CapsLock + j/k: Page Up/Page Down
  - CapsLock + Space: Enter
- **Scrolling (with Shift)**:
  - Shift + CapsLock + n/i/u/e: Scroll Left/Right/Up/Down
- **Browser-like Navigation**:
  - CapsLock + <: Go Back (Alt+Left)
  - CapsLock + >: Go Forward (Alt+Right)
- **Delete Word**:
  - CapsLock + m or Ctrl + CapsLock: Ctrl+Backspace
- **Number Row Shortcuts**:
  - CapsLock + q/w/f/a/r/s/x: Types 4/5/6/7/8/9/0
- **App Cycling (rcmd clone)**:
  - RAlt + [a–z]: Cycle through open apps by first letter or priority (e.g., RAlt+e cycles Edge, RAlt+t cycles Teams/Terminal)

### QWERTY Version

- **CapsLock Remapping**: CapsLock key is always off and repurposed for navigation and shortcuts.
- **Backspace Shortcut**: Tap CapsLock to send Backspace.
- **Visual Mode**: Toggle with CapsLock + v. Enables selection with navigation keys. _Automatically turns off after 10 seconds of inactivity._
- **Navigation**:
  - CapsLock + j/l/i/k: Move Left/Right/Up/Down (with selection in Visual Mode)
  - CapsLock + o/u: Move to next/previous word (with selection in Visual Mode)
  - CapsLock + h/;: Move to beginning/end of line (with selection in Visual Mode)
    - _Double-tap h or ; for Ctrl+Home or Ctrl+End (with selection in Visual Mode)_
  - CapsLock + p/n: Page Up/Page Down
  - CapsLock + Space: Enter
- **Scrolling (with Shift)**:
  - Shift + CapsLock + j/l/i/k: Scroll Left/Right/Up/Down
- **Browser-like Navigation**:
  - CapsLock + ,: Go Back (Alt+Left)
  - CapsLock + .: Go Forward (Alt+Right)
- **Delete Word**:
  - CapsLock + m or Ctrl + CapsLock: Ctrl+Backspace
- **Number Row Shortcuts**:
  - CapsLock + q/w/e/a/s/d/x: Types 4/5/6/7/8/9/0
- **App Cycling (rcmd clone)**:
  - RAlt + [a–z]: Cycle through open apps by first letter or priority (e.g., RAlt+e cycles Edge, RAlt+t cycles Teams/Terminal)

## Keybindings Summary

### Colemak

| Key Combo                  | Action                        |
| -------------------------- | ----------------------------- |
| CapsLock                   | Backspace                     |
| CapsLock + v               | Toggle Visual Mode            |
| CapsLock + n/i/u/e         | Left/Right/Up/Down            |
| Shift + CapsLock + n/i/u/e | Scroll Left/Right/Up/Down     |
| CapsLock + y/l             | Next/Previous Word            |
| CapsLock + h/o             | Home/End                      |
| CapsLock + hh/oo           | Ctrl+Home/Ctrl+End            |
| CapsLock + j/k             | Page Up/Page Down             |
| CapsLock + m               | Ctrl+Backspace (delete word)  |
| Ctrl + CapsLock            | Ctrl+Backspace (delete word)  |
| CapsLock + q/w/f/a/r/s/x   | Types 4/5/6/7/8/9/0           |
| CapsLock + Space           | Enter                         |
| CapsLock + <               | Go Back (Alt+Left)            |
| CapsLock + >               | Go Forward (Alt+Right)        |
| RAlt + [a–z]               | Cycle apps by letter/priority |

### QWERTY

| Key Combo                  | Action                        |
| -------------------------- | ----------------------------- |
| CapsLock                   | Backspace                     |
| CapsLock + v               | Toggle Visual Mode            |
| CapsLock + j/l/i/k         | Left/Right/Up/Down            |
| Shift + CapsLock + j/l/i/k | Scroll Left/Right/Up/Down     |
| CapsLock + o/u             | Next/Previous Word            |
| CapsLock + h/;             | Home/End                      |
| CapsLock + hh/;;           | Ctrl+Home/Ctrl+End            |
| CapsLock + p/n             | Page Up/Page Down             |
| CapsLock + m               | Ctrl+Backspace (delete word)  |
| Ctrl + CapsLock            | Ctrl+Backspace (delete word)  |
| CapsLock + q/w/e/a/s/d/x   | Types 4/5/6/7/8/9/0           |
| CapsLock + Space           | Enter                         |
| CapsLock + ,               | Go Back (Alt+Left)            |
| CapsLock + .               | Go Forward (Alt+Right)        |
| RAlt + [a–z]               | Cycle apps by letter/priority |

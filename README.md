# caps

> **Notice:** This script is designed for the Colemak keyboard layout. Keybindings may not match on other layouts.

Supercharge your CapsLock: lightning-fast navigation, selection, and app switching with one key.

## How to Use

1. **Install [AutoHotkey v2](https://www.autohotkey.com/download/).**
2. Download or clone this repository.
3. Double-click `caps.ahk` to run the script, or right-click and select "Run with AutoHotkey v2".
4. The script will now remap your CapsLock key and enable all features described below.
5. To stop the script, right-click the green "H" icon in your system tray and choose "Exit".

## Features

- **CapsLock Remapping**: CapsLock key is always off and repurposed for navigation and shortcuts.
- **Backspace Shortcut**: Tap CapsLock to send Backspace.
- **Visual Mode**: Toggle with CapsLock + v. Enables selection with navigation keys.
- **Navigation**:
  - CapsLock + n/i/u/e: Move Left/Right/Up/Down (with selection in Visual Mode)
  - CapsLock + y/l: Move to next/previous word (with selection in Visual Mode)
  - CapsLock + h/o: Move to beginning/end of line (with selection in Visual Mode)
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

## Keybindings Summary

| Key Combo                  | Action                        |
| -------------------------- | ----------------------------- |
| CapsLock                   | Backspace                     |
| CapsLock + v               | Toggle Visual Mode            |
| CapsLock + n/i/u/e         | Left/Right/Up/Down            |
| Shift + CapsLock + n/i/u/e | Scroll Left/Right/Up/Down     |
| CapsLock + y/l             | Next/Previous Word            |
| CapsLock + h/o             | Home/End                      |
| CapsLock + j/k             | Page Up/Page Down             |
| CapsLock + m               | Ctrl+Backspace (delete word)  |
| Ctrl + CapsLock            | Ctrl+Backspace (delete word)  |
| CapsLock + q/w/f/a/r/s/x   | Types 4/5/6/7/8/9/0           |
| CapsLock + Space           | Enter                         |
| CapsLock + <               | Go Back (Alt+Left)            |
| CapsLock + >               | Go Forward (Alt+Right)        |
| RAlt + [a–z]               | Cycle apps by letter/priority |

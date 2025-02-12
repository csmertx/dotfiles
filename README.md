# GhemxDS

A simple Qt-based timer app with system tray integration and desktop notifications.

## Features
- Start, stop, and reset the timer.
- Save and load timer configurations.
- Toggle between light and dark themes.
- Desktop notifications when the timer ends.

## Dependencies
- Qt 5
- DBus (for notifications)


## Install Dependencies

Ubuntu:

```sudo apt-get install qtbase5-dev qt5-qmake qt5-default libqt5dbus5 dbus build-essential```

Fedora:

```sudo dnf install qt5-qtbase-devel qt5-qmake qt5-qtbase qt5-qtbase-dbus dbus gcc-c++ make```

Arch Linux:

```sudo pacman -S qt5-base dbus base-devel```


## Compile & Install

1. ```qmake timer.pro && make```


2. ```./Ghemx```


Optional: Install KDE Connect for wearable and or mobile notifications

## GhemxDS

Bash script (CLI) egg timer 🔗 [ghemx](https://github.com/csmertx/ghemx "Github.com \ csmertx \ ghemx") I wrote several years ago.

The DS attributes DeepSeek for the C++ code generated over the course of three days and five separate chats.


## Help Menu via F1

```
1. Enter a title for your timer.

2. Set the hours, minutes, and seconds.

3. Click 'Start Timer' to begin.

4. Use the system tray icon to stop or restart the timer.

5. Save and load timers for future use.

6. Toggle between light and dark themes from the system tray menu.

7. The config file is located at: ~/.config/Ghemx/Timer.conf
```

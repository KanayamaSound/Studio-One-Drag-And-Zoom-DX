# Studio One Drag &amp; Zoom DX
This AutoHotKey V2 script enables you to use the WIN+MouseButton(s) to drag the view of your arrangement, piano-roll etc, and allows you to use the WIN+MouseWheel to zoom horizontally and vertically at the same time (like "pinch to zoom"). ***This fork adds drag to zoom which uses one of three hotkey setups, offering a different experience from the pinch to zoom style.*** Functionality can be enabled/disabled and adjusted using the menu by right clicking on the tray icon. It also comes with a "Run at startup" toggle so that you can start it up when your system boots and not have to think about it anymore.

## Original Drag Scroll functions and Mouse Wheel zoom are still available
![StudioOneDragAndZoom](https://github.com/Ronner/Studio-One-Drag-And-Zoom/assets/2070774/6f7d3ac3-95e8-4a05-b7fc-cb96f56b8a22)

## New Drag to Zoom function
![DragZoomDX](https://github.com/user-attachments/assets/c5163608-cbab-45c5-8f1f-d341b9277839)

_Simply select "Drag Zoom" from the Zoom menu (requires "Zoom Enabled" to be checked) and adjust settings to your liking in the tray menu._


Original Repo by Ronner (https://github.com/Ronner/Studio-One-Drag-And-Zoom)
Credits for the dragging part go to the contributors of this Github Repo: https://github.com/lokanchung/StudioPlusOne

# Horizontal only drag to scroll
When using WIN+RightMouseButton you will drag horizontally only. This should be used on the mixer/console because, otherwise, it can cause issues (See the caution below). If you prefer to have the "horizontal-only dragging" on the left mouse button and "both directions dragging" on the right mouse button, you can change that in the settings from the tray menu by selecting "Horizontal only on left mouse button"

# Caution when drag-scrolling on the console!
When using the drag to scroll functionality on the mixer/console, make sure to use WIN+RightMouseButton; otherwise, it can cause issues. This is due to the fact that, to achieve the dragging functionality, the script sends mousewheel commands to Studio One. However, when using the mousewheel on the mixer/console without shift, it can result in moving faders or changing other setttings.

# **New in DX version!* Drag to Zoom 
_(Requires some setup in Studio One>Keyboard Shortcuts)_

## -Advantages-
* Independent scrolling in both directions: As vertical scrolling has the unfortunate side effect of resizing track lanes and layers, some might prefer to separate the functions. Thus, it's still possible to vertically zoom in the Piano Roll by using a separte key function.
* Drag Zoom relies on the "Zoom fine" functions in the keyboard shortcuts settings, allowing for a smoother zooming experience over the mouse wheel

# REQUIRED SETUP for Drag Zoom
1. Go to the Keyboard Shortcuts settings in Studio One
2. Search for "Fine" and go to the "Zoom" category
3. Set "Zoom In Fine" to Ctrl+Alt+Right Arrow, "Zoom In Vertical Fine" to Ctrl+Alt+Up Arrow, "Zoom Out Fine" to Ctrl+Alt+Left Arrow, and "Zoom Out Vertical Fine" to Ctrl+Alt+Down Arrow
<img width="593" height="513" alt="ZoomSettings" src="https://github.com/user-attachments/assets/fadab9b8-26ea-4e39-9146-0004cda24f47" />


# Windows Only
Unfortunately this is a Windows only solution. Mac users will have to wait and see if PreSonus decides to put this type of functionality within Studio One itself. I sure hope they do so we do not have to resort to scripted workarounds like this.

# Installation
You can install this utility in one of two ways:

## 1. Easiest
Simply download the latest compiled .exe file from the [releases](https://github.com/KanayamaSound/Studio-One-Drag-And-Zoom-Dx/releases) page and run it (**NB**: It's a 64bit .exe).

## 2. Using AutoHotKey V2 
* Install AutoHotKey V2, which can be downloaded from the official [AutoHotKey.com](https://www.autohotkey.com/) website.
* Check out or download this repository.
* Double click the .ahk file to start the script.

# Accessing the settings

Running either the .exe or the .ahk file will not popup a program window. The only thing that is added is this tray icon (2nd icon from the left):
<img width="299" height="37" alt="tray" src="https://github.com/user-attachments/assets/62feb25c-a926-4535-9e6d-f4c854d13d72" />

Simply right click on this icon to show the settings menu. _(note: The menu will close when changing a setting. This is an annoying limitation of AutoHotkey's tray function.)_
<img width="344" height="286" alt="traymenu" src="https://github.com/user-attachments/assets/285f8bff-68f3-4a30-b00a-96c6d83052bb" />



If you do not see the icon, click on the "arrow up" icon on the left to show all tray icons available. It should be available there.

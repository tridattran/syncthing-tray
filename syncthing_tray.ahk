#NoTrayIcon
#Persistent

global hSyncthing

OnExit("ExitFunc")

/* Setup Tray icon and add item that will handle
 * double click events
 */
Menu Tray, NoStandard
Menu Tray, Icon
Menu Tray, Icon, syncthing.exe
Menu Tray, Add, Open WebUI, WebUI
Menu Tray, Default, Open WebUI
Menu Tray, Add, Show / Hide Console, TrayClick
Menu Tray, Add, Exit, Exit

;// Run Syncthing hidden
DetectHiddenWindows On
Run start_syncthing,, Hide, PID
WinWait ahk_pid %PID%
hSyncthing := WinExist()
DetectHiddenWindows Off
return

TrayClick:
OnTrayClick()
return

WebUI:
Run http://localhost:8384/
return

Exit:
ExitApp
return


;// Show / hide Syncthing on double click
OnTrayClick() {
	if DllCall("IsWindowVisible", "Ptr", hSyncthing) {
		WinHide ahk_id %hSyncthing%
	
	} else {
		WinShow ahk_id %hSyncthing%
		WinActivate ahk_id %hSyncthing%
	}
}

ExitFunc(ExitReason, ExitCode)
{
  WinShow ahk_id %hSyncthing%
  WinClose ahk_id %hSyncthing%
}
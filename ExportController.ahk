#NoEnv
#SingleInstance Off
#Include EstimateFolder.ahk
SendMode, Input

; Store path of archive directories.
ArchivePath1 := "E:\Archives\"
ArchivePath2 := "F:\Archives\"
if (A_ComputerName != "MILESTONESERVER")
{
	ArchivePath1 := "\\192.168.82.10\e\Archives\"
	ArchivePath2 := "\\192.168.82.10\f\Archives\"	
}

; Store path of destination.
FileSelectFolder, Destination, , 0, Choose export destination:
if (Destination = "")
{
	ExitApp
}
Destination := RegExReplace(Destination, "\\$")
Temp := Destination . "\"
Destination := Temp

; Max allowed export size (GB).
InputBox, MaxExportSize, Max Export Size, Enter the maximum export size in GB:
if (ErrorLevel)
{
	ExitApp
}
if MaxExportSize is not number
{
	MsgBox, 4112, Invalid Value, You entered an invalid value in the box. Please re-launch the app and try again.
	ExitApp
}

; Folder names based on MAC address for each camera.
FolderName1 := "ACCC8E0A5352_1"			; BNA Back
FolderName2 := "ACCC8E0D043D_2"			; BNA Load (Pano)
FolderName3 := "00408CF420E8_2"			; BNA Unload (Pano)
FolderName4 := "00408CFE0B13_2"			; Dept. 3A Back (Pano)
FolderName5 := "ACCC8E0D043B_2"			; Dept. 3A Front (Pano)
FolderName6 := "ACCC8E0A3F43_1"			; Dept. 3B + EN Back
FolderName7 := "00408CFE0B1A_2"			; Dept. 3B + EN Front (Pano)
FolderName8 := "00408CFF9368_1"			; Dept. 5 Back
FolderName9 := "00408CFE0B16_2"			; Dept. 5 Front (Pano)
FolderName10 := "00408CFE090D_1"		; Dept. 5 Operator (Full)
FolderName11 := "00408CFF93BA_1"		; Front Door
FolderName12 := "ACCC8E0D0446_1"		; Hot Room (Full)
FolderName13 := "00408CFF919F_1"		; Maintenance - Entrance
FolderName14 := "ACCC8E0D043F_2"		; Maintenance - Shop (Pano)
FolderName15 := "ACCC8E0A3F56_1"		; Mezzanine - Aisle Stairway
FolderName16 := "ACCC8E0A3EBD_1"		; Mezzanine - Back Stairway
FolderName17 := "ACCC8E0A3E99_1"		; Mezzanine - Interior Stairway
FolderName18 := "ACCC8E0A5353_1"		; Old Lab
FolderName19 := "ACCC8E0C0980_1"		; Outside - Employee Entrance (Full)
FolderName20 := "ACCC8E0C0984_1"		; Outside - Gazebo (Full)
FolderName21 := "ACCC8E0C08C5_2"		; Outside - Parking Lot (Pano)
FolderName22 := "ACCC8E0C0988_2"		; Outside - Shipping (Pano)
FolderName23 := "ACCC8E0C0982_1"		; Outside - Transformer (Full)
FolderName24 := "ACCC8E0C0986_2"		; Outside - Warehouse (Pano)
FolderName25 := "ACCC8E0D0442_1"		; Plant Front (Full)
FolderName26 := "ACCC8E0A52DB_1"		; Robot Back
FolderName27 := "00408CFE0B1E_2"		; Robot Front (Pano)
FolderName28 := "ACCC8E0A52EF_1"		; Shipping - Dock Doors
FolderName29 := "ACCC8E0D0441_2"		; Shipping (Pano)
FolderName30 := "ACCC8E0A3130_1"		; Visitor Hallway
FolderName31 := "ACCC8E0D043A_1"		; Warehouse - Back (Full)
FolderName32 := "ACCC8E0D0440_1"		; Warehouse - QC2 (Full)

ShowGui:
Gui, Font, s7 cDefault, Verdana
Gui, Add, StatusBar
SB_SetText("Destination: " . Destination . "`t`tMax: " . MaxExportSize . "GB")
;SB_SetText("`tMax GB: " . MaxExportSize, 2, 0)
Gui, Font, s8 cDefault, Verdana
Gui, Add, CheckBox, x12 y30 w290 h20 vCamSelected1 gCheckboxToggleButtons, BNA Back
Gui, Add, CheckBox, x12 y50 w290 h20 vCamSelected2 gCheckboxToggleButtons, BNA Load (Pano)
Gui, Add, CheckBox, x12 y70 w290 h20 vCamSelected3 gCheckboxToggleButtons, BNA Unload (Pano)
Gui, Add, CheckBox, x12 y90 w290 h20 vCamSelected4 gCheckboxToggleButtons, Dept. 3A Back (Pano)
Gui, Add, CheckBox, x12 y110 w290 h20 vCamSelected5 gCheckboxToggleButtons, Dept. 3A Front (Pano)
Gui, Add, CheckBox, x12 y130 w290 h20 vCamSelected6 gCheckboxToggleButtons, Dept. 3B + EN Back
Gui, Add, CheckBox, x12 y150 w290 h20 vCamSelected7 gCheckboxToggleButtons, Dept. 3B + EN Front (Pano)
Gui, Add, CheckBox, x12 y170 w290 h20 vCamSelected8 gCheckboxToggleButtons, Dept. 5 Back
Gui, Add, CheckBox, x12 y190 w290 h20 vCamSelected9 gCheckboxToggleButtons, Dept. 5 Front (Pano)
Gui, Add, CheckBox, x12 y210 w290 h20 vCamSelected10 gCheckboxToggleButtons, Dept. 5 Operator (Full)
Gui, Add, CheckBox, x12 y230 w290 h20 vCamSelected11 gCheckboxToggleButtons, Front Door
Gui, Add, CheckBox, x12 y250 w290 h20 vCamSelected12 gCheckboxToggleButtons, Hot Room (Full)
Gui, Add, CheckBox, x12 y270 w290 h20 vCamSelected13 gCheckboxToggleButtons, Maintenance - Entrance
Gui, Add, CheckBox, x12 y290 w290 h20 vCamSelected14 gCheckboxToggleButtons, Maintenance - Shop (Pano)
Gui, Add, CheckBox, x12 y310 w290 h20 vCamSelected15 gCheckboxToggleButtons, Mezzanine - Aisle Stairway
Gui, Add, CheckBox, x12 y330 w290 h20 vCamSelected16 gCheckboxToggleButtons, Mezzanine - Back Stairway
Gui, Add, CheckBox, x302 y30 w290 h20 vCamSelected17 gCheckboxToggleButtons, Mezzanine - Interior Stairway
Gui, Add, CheckBox, x302 y50 w290 h20 vCamSelected18 gCheckboxToggleButtons, Old Lab
Gui, Add, CheckBox, x302 y70 w290 h20 vCamSelected19 gCheckboxToggleButtons, Outside - Employee Entrance (Full)
Gui, Add, CheckBox, x302 y90 w290 h20 vCamSelected20 gCheckboxToggleButtons, Outside - Gazebo (Full)
Gui, Add, CheckBox, x302 y110 w290 h20 vCamSelected21 gCheckboxToggleButtons, Outside - Parking Lot (Pano)
Gui, Add, CheckBox, x302 y130 w290 h20 vCamSelected22 gCheckboxToggleButtons, Outside - Shipping (Pano)
Gui, Add, CheckBox, x302 y150 w290 h20 vCamSelected23 gCheckboxToggleButtons, Outside - Transformer (Full)
Gui, Add, CheckBox, x302 y170 w290 h20 vCamSelected24 gCheckboxToggleButtons, Outside - Warehouse (Pano)
Gui, Add, CheckBox, x302 y190 w290 h20 vCamSelected25 gCheckboxToggleButtons, Plant Front (Full)
Gui, Add, CheckBox, x302 y210 w290 h20 vCamSelected26 gCheckboxToggleButtons, Robot Back
Gui, Add, CheckBox, x302 y230 w290 h20 vCamSelected27 gCheckboxToggleButtons, Robot Front (Pano)
Gui, Add, CheckBox, x302 y250 w290 h20 vCamSelected28 gCheckboxToggleButtons, Shipping - Dock Doors
Gui, Add, CheckBox, x302 y270 w290 h20 vCamSelected29 gCheckboxToggleButtons, Shipping (Pano)
Gui, Add, CheckBox, x302 y290 w290 h20 vCamSelected30 gCheckboxToggleButtons, Visitor Hallway
Gui, Add, CheckBox, x302 y310 w290 h20 vCamSelected31 gCheckboxToggleButtons, Warehouse - Back (Full)
Gui, Add, CheckBox, x302 y330 w290 h20 vCamSelected32 gCheckboxToggleButtons, Warehouse - QC2 (Full)
Gui, Add, DateTime, x12 y380 w210 h30 vStartDate gCheckboxToggleButtons, 
Gui, Add, DateTime, x382 y380 w210 h30 vEndDate gCheckboxToggleButtons, 
Gui, Add, Text, x222 y390 w160 h20 +Center, through
Gui, Font, s8 cDefault Bold, Verdana
Gui, Add, Text, x12 y10 w440 h20 vLabel1, Select cameras for export:
Gui, Add, Text, x12 y360 w440 h20 vLabel2, Select date range for export:
Gui, Add, Button, x385 y420 w100 h30 gTestButtonClick vTestButton, &Test Export
Gui, Add, Button, x492 y420 w100 h30 gStartButtonClick vStartButton, Start &Export
Gui, Add, Text, x12 y425 w350 h20 vMessage,
GuiControl, Disable, StartButton
Gui, Show, w604 h485, Milestone Export Controller
Return

GuiClose:
ExitApp

TestButtonClick:
Gui, Submit, NoHide
GuiControl, Text, Message
CameraCount = 0
Loop, 32
{
	IfEqual, CamSelected%A_Index%, 1, EnvAdd, CameraCount, 1
}
if (CameraCount = 0) {
	Gui, Font, cRed Bold
	GuiControl, Font, Message
	GuiControl, Text, Message, You did not select any cameras for exporting.
	Return
}
if (StartDate > EndDate) {
	Gui, Font, cRed Bold
	GuiControl, Font, Message
	GuiControl, Text, Message, Selected starting date later than ending date.
	Return
}
Gui, Font, cBlue Bold
GuiControl, Font, Message
GuiControl, Text, Message, Estimating size of export data. Please wait...
GuiControl, Disable, TestButton
TotalSize = 0
Loop, 32
{
	IfEqual, CamSelected%A_Index%, 1, EnvAdd, TotalSize, EstimateFolder(ArchivePath1, ArchivePath2, FolderName%A_Index%, StartDate, EndDate)
}
if (TotalSize = 0) {
	Gui, Font, cRed Bold
	GuiControl, Font, Message
	GuiControl, Text, Message, No export data found.
	GuiControl, Enable, TestButton
	Return
}
ExportSizeGB := Round((((TotalSize/1024)/1024)/1024), 2)
if (ExportSizeGB > MaxExportSize) {
	Gui, Font, cRed Bold
	GuiControl, Font, Message
	GuiControl, Text, Message, Export too large (%ExportSizeGB% GB > %MaxExportSize% GB).
	GuiControl, Enable, TestButton
	Return
}
Gui, Font, cGreen Bold
GuiControl, Font, Message
GuiControl, Text, Message, Estimated export size: %ExportSizeGB% GB. OK to proceed.
GuiControl, Enable, StartButton
Return

StartButtonClick:
ExportStart := A_TickCount
Gui, Submit, NoHide
GuiControl, Text, Message
GuiControl, Disable, StartButton
Gosub, DisableEverything
TotalSize = 0
Loop, 32
{
	IfEqual, CamSelected%A_Index%, 1, EnvAdd, TotalSize, EstimateFolder(ArchivePath1, ArchivePath2, FolderName%A_Index%, StartDate, EndDate)
}
GuiControl, Move, Message, y2000
Gui, Add, Progress, w300 h10 x12 y430 cBlue Background999999 vExportProgress
Loop, 32
{
	if (CamSelected%A_Index% = 1)
	{
		CopyFolder(ArchivePath1, ArchivePath2, FolderName%A_Index%, StartDate, EndDate, Destination, TotalSize)
	}
}
ExportFinished := A_TickCount
Duration := Round((ExportFinished - ExportStart) / 1000, 2)
GuiControl, , ExportProgress, 100
MsgBox, 4160, Export Finished, Export finished in %Duration% seconds.
Return

CheckboxToggleButtons:
GuiControl, Text, Message
GuiControl, Enable, TestButton
GuiControl, Disable, StartButton
Return

DisableEverything:
Loop, 32
{
	GuiControl, Disable, CamSelected%A_Index%
}
GuiControl, Disable, StartDate
GuiControl, Disable, EndDate
GuiControl, Disable, Label1
GuiControl, Disable, Label2
Return
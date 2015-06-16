EstimateFolder(Archive1, Archive2, Folder, StartDate, EndDate)
{	
	; Store reference to last day.
	FormatTime, LastDate, %EndDate%, yyyy-MM-dd
	
	; Initialize date.
	FormatTime, CurrentDate, %StartDate%, yyyy-MM-dd
	
	; Initialize size to 0.
	TotalSize = 0
	
	; Check all dates in range.
	while (CurrentDate <= LastDate)
	{
		
		; Check archives.
		Loop, 2
		{
			CurrentPath := Archive%A_Index% . Folder . "\" . CurrentDate . "*"
			Loop, %CurrentPath%, 2
			{
				EnvAdd, TotalSize, FolderSize(A_LoopFileFullPath)
			}
		}
		
		; Increment date.
		EnvAdd, StartDate, 1, Days
		FormatTime, CurrentDate, %StartDate%, yyyy-MM-dd
	
	}
		
	; Check archives.
	Loop, 2
	{
		CurrentPath := Archive%A_Index% . Folder . "\" . CurrentDate . "*"
		Loop, %CurrentPath%, 2
		{
			EnvAdd, TotalSize, FolderSize(A_LoopFileFullPath)
			Break
		}
	}
	
	; Return total size.
	Return TotalSize	
}

FolderSize(Folder)
{
	SetBatchLines, -1
	ThisFolderSize = 0
	Loop, %Folder%\*.*, , 1
	{
		ThisFolderSize += %A_LoopFileSize%
	}
	Return ThisFolderSize
}

CopyFolder(Archive1, Archive2, Folder, StartDate, EndDate, Destination, TotalSize)
{
	; Store reference to last day.
	FormatTime, LastDate, %EndDate%, yyyy-MM-dd
	
	; Initialize date.
	FormatTime, CurrentDate, %StartDate%, yyyy-MM-dd
	
	; Check all dates in range.
	while (CurrentDate <= LastDate)
	{
		
		; Check archives.
		Loop, 2
		{
			CurrentPath := Archive%A_Index% . Folder . "\" . CurrentDate . "*"
			Loop, %CurrentPath%, 2
			{
				ThisFolderSize := FolderSize(A_LoopFileFullPath)
				ThisFolderPercentage := 100 * (ThisFolderSize / TotalSize)
				DestinationPath := Destination . Folder . "\" . A_LoopFileName
				FileCopyDir, %A_LoopFileFullPath%, %DestinationPath%, 1
				GuiControl, , ExportProgress, +%ThisFolderPercentage%
			}
		}
		
		; Increment date.
		EnvAdd, StartDate, 1, Days
		FormatTime, CurrentDate, %StartDate%, yyyy-MM-dd
	
	}
	
	Loop, 2
	{
		CurrentPath := Archive%A_Index% . Folder . "\" . CurrentDate . "*"
		Loop, %CurrentPath%, 2
		{
			ThisFolderSize := FolderSize(A_LoopFileFullPath)
			ThisFolderPercentage := 100 * (ThisFolderSize / TotalSize)
			DestinationPath := Destination . Folder . "\" . A_LoopFileName
			FileCopyDir, %A_LoopFileFullPath%, %DestinationPath%, 1
			GuiControl, , ExportProgress, +%ThisFolderPercentage%
			Break
		}
	}
}
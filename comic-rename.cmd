@ ECHO OFF
REM - -WARNING- - this command will also change all files in the selected folder to a .png - use cautiously.
REM %1 is the name of the folder you want to batch rename in
REM %2 is the prefix you want to give each of the files

IF "%1"=="" (
  SET /P folderName="Name of folder to rename in:"
  SET /P fileName="Abreviation to rename to:"
) ELSE (
  SET folderName=%1
  IF "%2"=="" (
    SET /P fileName="Abreviation to rename to:"
  ) ELSE (
	  SET fileName=%2
  )
)

IF EXIST %folderName% (
  FOR /F "usebackq" %%f IN (`dir /b %folderName%`) DO (
    RENAME %folderName%\%%f "%fileName% (%%~nf).png"
  )
) ELSE (
  SET /P display_user_message="folderName cannot be found in root"
)

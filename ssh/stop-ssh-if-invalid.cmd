@ echo off

rem Check if ssh-add passphrase was skipped.
ssh-add -l > "%~dp0ssh-information.tmp"
  set /p ssh_info=<"%~dp0ssh-information.tmp"
del "%~dp0ssh-information.tmp"

rem If it was skipped, stop the session.
if "%ssh_info%" == "The agent has no identities." (
  call "%~dp0stop-ssh"
)

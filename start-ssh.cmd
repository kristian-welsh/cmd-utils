@ echo off
rem To start an ssh session:
rem 1. Set variables needed for ssh-add from ssh-agent output.
rem 2. Run ssh-add on ~/.ssh/id_rsa
rem 3. Stop the session if the user skipped the passphrase.

rem Note: After first run seems to continue to work in new same window cmd sessions, but new window cmd sessions throw permission denied in ssh -T

rem Delayed expansion needed to seperate output lines.
setlocal EnableDelayedExpansion
  
  rem Save ssh-agent information to file for recovery.
  ssh-agent > "%~dp0ssh-agent-output.tmp"

    rem Extract each line of output into it's own variable.
    set /a num=0
    for /f "usebackq tokens=*" %%A in ("%~dp0ssh-agent-output.tmp") do (
      set /a num+=1
      set ssh_agent_output_line!num!=%%A
    )

  del "%~dp0ssh-agent-output.tmp"
  
  rem Extract valuable data from output lines.
  set SSH_AUTH_SOCK=%ssh_agent_output_line1:~14,32%
  set SSH_AGENT_PID=%ssh_agent_output_line2:~14,4%  
  
endlocal&(
set SSH_AUTH_SOCK=%SSH_AUTH_SOCK%
set SSH_AGENT_PID=%SSH_AGENT_PID%)

rem Start the session.
ssh-add "%userprofile%\.ssh\id_rsa"

rem Check if ssh-add passphrase was skipped.
ssh-add -l > "%~dp0ssh-information.tmp"
  set /p ssh_info=<"%~dp0ssh-information.tmp"
del "%~dp0ssh-information.tmp"

rem If it was skipped, stop the session.
if "%ssh_info%" == "The agent has no identities." (
  call stop-ssh
)

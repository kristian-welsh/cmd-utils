rem Start an ssh session.
rem Set needed variables from ssh-agent output, then run ssh-add.
@ echo off

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
  
  rem Extract data from output lines.
  set SSH_AUTH_SOCK=%ssh_agent_output_line1:~14,32%
  set SSH_AGENT_PID=%ssh_agent_output_line2:~14,4%  
  
endlocal&(
set SSH_AUTH_SOCK=%SSH_AUTH_SOCK%
set SSH_AGENT_PID=%SSH_AGENT_PID%)

rem ssh-add needs to happen outside of local space.
ssh-add "%userprofile%\.ssh\id_rsa"

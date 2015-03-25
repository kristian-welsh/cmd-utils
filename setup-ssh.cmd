@ echo off

rem ToDo: Don't start an ssh-agent if there's already one on the task list.

rem start an ssh session
rem To setup an ssh connection you extract first two lines of output from ssh-agent to set output as a variable (minus end part). Then run ssh-add on id_rsa
setlocal EnableDelayedExpansion

  ssh-agent > "%~dp0ssh-agent-output.tmp"
    rem extract each line of output into it's own variable
    set /a num=0
    for /f "usebackq tokens=*" %%A in ("%~dp0ssh-agent-output.tmp") do (
      set /a num+=1
      set ssh_agent_output_line!num!=%%A
    )
  del "%~dp0ssh-agent-output.tmp"
  
  rem extract data from ssh-agent output and set the variables
  set SSH_AUTH_SOCK=%ssh_agent_output_line1:~14,32%
  set SSH_AGENT_PID=%ssh_agent_output_line2:~14,4%
  
  ssh-add "%userprofile%\.ssh\id_rsa"
endlocal

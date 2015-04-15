rem start an ssh session
@ echo off

rem Extract output from ssh-agent and set variables from output, then run ssh-add

setlocal EnableDelayedExpansion

  ssh-agent > "%~dp0ssh-agent-output.tmp"
    rem extract each line of output into it's own variable
    set /a num=0
    for /f "usebackq tokens=*" %%A in ("%~dp0ssh-agent-output.tmp") do (
      set /a num+=1
      set ssh_agent_output_line!num!=%%A
    )
  del "%~dp0ssh-agent-output.tmp"
  
  rem extract data from output
  set SSH_AUTH_SOCK=%ssh_agent_output_line1:~14,32%
  set SSH_AGENT_PID=%ssh_agent_output_line2:~14,4%  
endlocal&(
set SSH_AUTH_SOCK=%SSH_AUTH_SOCK%
set SSH_AGENT_PID=%SSH_AGENT_PID%)

ssh-add "%userprofile%\.ssh\id_rsa"

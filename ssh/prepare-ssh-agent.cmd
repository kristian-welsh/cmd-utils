@ echo off
rem Delayed expansion needed to seperate output lines.
setlocal EnableDelayedExpansion
  
  rem Save ssh-agent information to file for recovery.
  ssh-agent > "%~dp0ssh-agent-output.tmp"

    rem Extract each line of output into it's own variable.
    set /a num=0
    rem For each line in output file
    for /f "tokens=* usebackq" %%a in ("%~dp0ssh-agent-output.tmp") do (
      set /a num+=1
      set ssh_agent_output_line!num!=%%a
    )

  del "%~dp0ssh-agent-output.tmp"
  
  rem Extract valuable data from output lines.
  set SSH_AUTH_SOCK=%ssh_agent_output_line1:~14,32%
  set SSH_AGENT_PID=%ssh_agent_output_line2:~14,4%  
  
endlocal&(
set SSH_AUTH_SOCK=%SSH_AUTH_SOCK%
set SSH_AGENT_PID=%SSH_AGENT_PID%)

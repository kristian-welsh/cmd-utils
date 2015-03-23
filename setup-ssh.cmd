@ echo off
rem Extract first two lines of output from ssh-agent to set output as a variable (minus end part). Then run ssh-add on %~%/.ssh/id_rsa

rem probably should change the temp file path to be %~dp0
echo ssh-setup is incomplete

setlocal EnableDelayedExpansion

ssh-agent > ssh-agent-output.tmp
  rem extract each line of output into it's own variable
  set /a num=0
  for /f "tokens=*" %%a in (ssh-agent-output.tmp) do (
    set /a num+=1
    set output_line!num!=%%a
  )
del ssh-agent-output.tmp

rem endlocal and call set on the final output lines to complete proccess
endlocal & set %output_line1:~0,-23% & set %output_line2:~0,-23%

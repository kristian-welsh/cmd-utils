@ echo off
REM need to extract the first two lines of the output from ssh-agent and slap a set before them then run that as a command minus the end bit), then run ssh-add and we should be golden
echo setup-ssh.cmd is incomplete

ssh-agent > ssh-agent-output.tmp
set /p output_line1=<ssh-agent-output.tmp
del ssh-agent-output.tmp

REM use ssh-agent-output to set the apropriate values
set %output_line1:~0,-23%
set SSH_AUTH_SOCK

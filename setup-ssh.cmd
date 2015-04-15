@ echo off
rem count number of active ssh-agent procceses
tasklist /fi "imagename eq ssh-agent.exe" | find /C "ssh-agent.exe" > "%~dp0ssh-agent-task-count.tmp"
  set /p active_ssh_agents=<"%~dp0ssh-agent-task-count.tmp"
del "%~dp0ssh-agent-task-count.tmp"

rem if there isn't an active ssh session, start a new one.
if %active_ssh_agents% lss 1 (
  echo starting new ssh session.
  call start-ssh.cmd
) else (
  echo ssh session already active.
)

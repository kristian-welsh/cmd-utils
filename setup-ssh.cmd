@ echo off

rem TODO: Only run on first call to git push.

rem Count active ssh-agent procceses.
tasklist /fi "imagename eq ssh-agent.exe" | find /C "ssh-agent.exe" > "%~dp0ssh-agent-task-count.tmp"
  set /p active_ssh_agents=<"%~dp0ssh-agent-task-count.tmp"
del "%~dp0ssh-agent-task-count.tmp"

rem If ssh isn't running, start ssh.
if %active_ssh_agents% lss 1 (
  echo starting new ssh session.
  call start-ssh.cmd
) else (
  echo ssh session already active.
)

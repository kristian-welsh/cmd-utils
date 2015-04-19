@ echo off

rem Note: After first run seems to continue to work in new same window cmd sessions, but new window cmd sessions throw permission denied in ssh -T
rem calls start ssh\ as they are run with current dir one dir up

rem TODO: Only run on first call to git push.
rem TODO: Custom status outputs

rem Count active ssh-agent procceses.
tasklist /fi "imagename eq ssh-agent.exe" | find /C "ssh-agent.exe" > "%~dp0ssh-agent-task-count.tmp"
  set /p active_ssh_agents=<"%~dp0ssh-agent-task-count.tmp"
del "%~dp0ssh-agent-task-count.tmp"

rem If ssh isn't running, start ssh.
if %active_ssh_agents% lss 1 (
  echo starting new ssh session.
  call "%~dp0prepare-ssh-agent"
  call "%~dp0start-ssh"
  call "%~dp0stop-ssh-if-invalid"
) else (
  echo ssh session already active.
)

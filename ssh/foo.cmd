@ echo off
for /f "tokens=* usebackq" %%a in (`ls`) do (
  echo %%a
)

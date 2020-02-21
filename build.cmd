@echo off
set MISSION_NAME=PG_free_the_gulf
echo.
echo ----------------------------------------
echo building %MISSION_NAME%
echo ----------------------------------------
echo.

rem -- default options values
echo This script can use these environment variables to customize its behavior :
echo ----------------------------------------
echo VERBOSE_LOG_FLAG if set to "true", will create a mission with tracing enabled (meaning that, when run, it will log a lot of details in the dcs log file)
echo defaults to "false"
IF [%VERBOSE_LOG_FLAG%] == [] GOTO DefineDefaultVERBOSE_LOG_FLAG
goto DontDefineDefaultVERBOSE_LOG_FLAG
:DefineDefaultVERBOSE_LOG_FLAG
set VERBOSE_LOG_FLAG=false
:DontDefineDefaultVERBOSE_LOG_FLAG
echo current value is "%VERBOSE_LOG_FLAG%"

echo ----------------------------------------
echo LUA_SCRIPTS_DEBUG_PARAMETER can be set to "-debug" or "-trace" (or not set) ; this will be passed to the lua helper scripts (e.g. veafMissionRadioPresetsEditor and veafMissionNormalizer)
echo defaults to not set
IF [%LUA_SCRIPTS_DEBUG_PARAMETER%] == [] GOTO DefineDefaultLUA_SCRIPTS_DEBUG_PARAMETER
goto DontDefineDefaultLUA_SCRIPTS_DEBUG_PARAMETER
:DefineDefaultLUA_SCRIPTS_DEBUG_PARAMETER
set LUA_SCRIPTS_DEBUG_PARAMETER=
:DontDefineDefaultLUA_SCRIPTS_DEBUG_PARAMETER
echo current value is "%LUA_SCRIPTS_DEBUG_PARAMETER%"

echo ----------------------------------------
echo SECURITY_DISABLED_FLAG if set to "true", will create a mission with security disabled (meaning that no password is ever required)
echo defaults to "false"
IF [%SECURITY_DISABLED_FLAG%] == [] GOTO DefineDefaultSECURITY_DISABLED_FLAG
goto DontDefineDefaultSECURITY_DISABLED_FLAG
:DefineDefaultSECURITY_DISABLED_FLAG
set SECURITY_DISABLED_FLAG=false
:DontDefineDefaultSECURITY_DISABLED_FLAG
echo current value is "%SECURITY_DISABLED_FLAG%"

echo ----------------------------------------
echo MISSION_FILE_SUFFIX (a string) will be appended to the mission file name to make it more unique
echo defaults to the current iso date
IF [%MISSION_FILE_SUFFIX%] == [] GOTO DefineDefaultMISSION_FILE_SUFFIX
goto DontDefineDefaultMISSION_FILE_SUFFIX
:DefineDefaultMISSION_FILE_SUFFIX
set TIMEBUILD=%TIME: =0%
set MISSION_FILE_SUFFIX=%date:~-4,4%%date:~-7,2%%date:~-10,2%
:DontDefineDefaultMISSION_FILE_SUFFIX
set MISSION_FILE=.\build\%MISSION_NAME%_%MISSION_FILE_SUFFIX%
echo current value is "%MISSION_FILE_SUFFIX%"

echo ----------------------------------------
echo SEVENZIP (a string) points to the 7za executable
echo defaults "7za", so it needs to be in the path
IF ["%SEVENZIP%"] == [""] GOTO DefineDefaultSEVENZIP
goto DontDefineDefaultSEVENZIP
:DefineDefaultSEVENZIP
set SEVENZIP=7za
:DontDefineDefaultSEVENZIP
echo current value is "%SEVENZIP%"

echo ----------------------------------------
echo LUA (a string) points to the lua executable
echo defaults "lua", so it needs to be in the path
IF ["%LUA%"] == [""] GOTO DefineDefaultLUA
goto DontDefineDefaultLUA
:DefineDefaultLUA
set LUA=lua
:DontDefineDefaultLUA
echo current value is "%LUA%"
echo ----------------------------------------

echo.
echo fetching the veaf-mission-creation-tools package
call npm update
rem echo on

rem -- prepare the folders
echo preparing the folders
rd /s /q .\build
mkdir .\build
mkdir .\build\tempsrc

echo building the mission
rem -- copy all the source mission files and mission-specific scripts
xcopy /y /e src\mission .\build\tempsrc\ >nul 2>&1
xcopy /y src\options .\build\tempsrc\  >nul 2>&1
xcopy /y /e src\scripts\*.lua .\build\tempsrc\l10n\Default\  >nul 2>&1

rem -- set the radio presets according to the settings file
echo set the radio presets according to the settings file
pushd node_modules\veaf-mission-creation-tools\scripts\veaf
"%LUA%" veafMissionRadioPresetsEditor.lua  ..\..\..\..\build\tempsrc ..\..\..\..\src\radioSettings.lua %LUA_SCRIPTS_DEBUG_PARAMETER%
popd

rem -- copy the documentation images to the kneeboard
xcopy /y /e doc\*.png .\build\tempsrc\KNEEBOARD\IMAGES\ >nul 2>&1

rem -- copy all the community scripts
copy .\src\scripts\community\*.lua .\build\tempsrc\l10n\Default  >nul 2>&1
copy .\node_modules\veaf-mission-creation-tools\scripts\community\*.lua .\build\tempsrc\l10n\Default  >nul 2>&1

rem -- copy all the common scripts
copy .\node_modules\veaf-mission-creation-tools\scripts\veaf\*.lua .\build\tempsrc\l10n\Default  >nul 2>&1

rem -- set the flags in the scripts according to the options
powershell -Command "(gc .\build\tempsrc\l10n\Default\veaf.lua) -replace 'veaf.Development = false', 'veaf.Development = %VERBOSE_LOG_FLAG%' | sc .\build\tempsrc\l10n\Default\veaf.lua" >nul 2>&1
powershell -Command "(gc .\build\tempsrc\l10n\Default\veaf.lua) -replace 'veaf.SecurityDisabled = false', 'veaf.SecurityDisabled = %SECURITY_DISABLED_FLAG%' | sc .\build\tempsrc\l10n\Default\veaf.lua" >nul 2>&1

rem -- normalize and prepare the version for night
echo normalize and prepare the version for night
pushd node_modules\veaf-mission-creation-tools\scripts\veaf
"%LUA%" veafMissionNormalizer.lua ..\..\..\..\build\tempsrc ..\..\..\..\src\weatherAndTime-night.lua %LUA_SCRIPTS_DEBUG_PARAMETER%
popd

rem -- compile the mission
"%SEVENZIP%" a -r -tzip %MISSION_FILE%-night.miz .\build\tempsrc\* -mem=AES256 >nul 2>&1

rem -- normalize and prepare the version for dawn
echo normalize and prepare the version for dawn
pushd node_modules\veaf-mission-creation-tools\scripts\veaf
"%LUA%" veafMissionNormalizer.lua ..\..\..\..\build\tempsrc ..\..\..\..\src\weatherAndTime-dawn.lua %LUA_SCRIPTS_DEBUG_PARAMETER%
popd

rem -- compile the mission
"%SEVENZIP%" a -r -tzip %MISSION_FILE%-dawn.miz .\build\tempsrc\* -mem=AES256 >nul 2>&1

rem -- normalize and prepare the version for noon
echo normalize and prepare the version for noon
pushd node_modules\veaf-mission-creation-tools\scripts\veaf
"%LUA%" veafMissionNormalizer.lua ..\..\..\..\build\tempsrc ..\..\..\..\src\weatherAndTime-noon.lua %LUA_SCRIPTS_DEBUG_PARAMETER%
popd

rem -- compile the mission
"%SEVENZIP%" a -r -tzip %MISSION_FILE%-noon.miz .\build\tempsrc\* -mem=AES256 >nul 2>&1

rem -- normalize and prepare the version for afternoon
echo normalize and prepare the version for afternoon
pushd node_modules\veaf-mission-creation-tools\scripts\veaf
"%LUA%" veafMissionNormalizer.lua ..\..\..\..\build\tempsrc ..\..\..\..\src\weatherAndTime-afternoon.lua %LUA_SCRIPTS_DEBUG_PARAMETER%
popd

rem -- compile the mission
"%SEVENZIP%" a -r -tzip %MISSION_FILE%-afternoon.miz .\build\tempsrc\* -mem=AES256 >nul 2>&1

rem -- normalize and prepare the version for dusk
echo normalize and prepare the version for dusk
pushd node_modules\veaf-mission-creation-tools\scripts\veaf
"%LUA%" veafMissionNormalizer.lua ..\..\..\..\build\tempsrc ..\..\..\..\src\weatherAndTime-dusk.lua %LUA_SCRIPTS_DEBUG_PARAMETER%
popd

rem -- compile the mission
"%SEVENZIP%" a -r -tzip %MISSION_FILE%-dusk.miz .\build\tempsrc\* -mem=AES256 >nul 2>&1

rem -- normalize and prepare the version for morning-storm
echo normalize and prepare the version for morning-storm
pushd node_modules\veaf-mission-creation-tools\scripts\veaf
"%LUA%" veafMissionNormalizer.lua ..\..\..\..\build\tempsrc ..\..\..\..\src\weatherAndTime-morning-storm.lua %LUA_SCRIPTS_DEBUG_PARAMETER%
popd

rem -- compile the mission
"%SEVENZIP%" a -r -tzip %MISSION_FILE%-morning-storm.miz .\build\tempsrc\* -mem=AES256 >nul 2>&1

rem -- cleanup
rd /s /q .\build\tempsrc

echo.
echo ----------------------------------------
rem -- done !
echo Built %MISSION_FILE%.miz
echo ----------------------------------------

pause
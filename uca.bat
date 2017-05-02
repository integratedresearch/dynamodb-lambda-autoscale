@echo off
if not exist "C:\Program Files\Amazon\AWSCLI\aws.exe" goto missing-error

call npm install

if "%1"=="" goto options
set stage=%1

if "%2"=="" goto options
set region=%2
echo {"Region":"%region%"} > src\configuration\Region.json

echo TABLES_NAMES=uca-api-agents-%stage%,uca-api-assessment-data-media-5min-%stage%,uca-api-assessment-data-media-%stage%,uca-api-assessment-data-media-raw-%stage%,uca-api-assessment-data-media-summary-%stage%,uca-api-assessment-data-route-%stage%,uca-api-assessment-data-route-raw-%stage%,uca-api-assessment-data-wifi-%stage%,uca-api-assessment-data-wifi-raw-%stage%,uca-api-assessment-data-wifi-5min-%stage%,uca-api-assessment-data-wifi-con-%stage%,uca-api-assessment-instances-%stage%,uca-api-instances-%stage%,uca-api-assessments-%stage%,uca-api-projects-%stage% > config.env.production
goto done

:missing-error
echo.
echo It seems you do not have AWS CLI, a prerequisite for running this batch file. 
echo.
echo 1) Follow the instructions given on this web page to install AWS CLI on your Windows PC: 
echo    http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-windows.html
echo.
echo 2) Obtain access key ID and secret access key for the ucassessor-development account (ask your teammate).
echo.
echo 3) Enter those credentials by running the command 'aws configure', when asked enter 'ap-southeast-2' for the region.
echo.
echo 4) Come back and run this batch file.
goto done

:options
echo. 
echo Usage:
echo uca.bat stage region
echo.
echo Examples:
echo uca dev ap-southeast-2
echo uca uat us-west-2

:done
echo.
echo ** Done.

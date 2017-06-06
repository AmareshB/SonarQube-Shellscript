
@echo off
setlocal enabledelayedexpansion



echo Enter the location of sonar folder
set /p sonarFilePath=
echo sonarFilePath = %sonarFilePath% > configSonar.xml

echo(
echo #----- Default SonarQube server >> %sonarFilePath%\sonar-runner-2.4\conf\sonar-runner.properties
echo sonar.host.url=http://tbwacss03atsvg.tdc.vzwcorp.com:9000 >> %sonarFilePath%\sonar-runner-2.4\conf\sonar-runner.properties

echo #Reading adebp id and password
echo enter your username
set /p username=
echo %username% >> configSonar.xml

echo enter your password
set /p pass=
echo %pass% >> configSonar.xml

echo(
echo #----- Security (when 'sonar.forceAuthentication' is set to 'true') >> %sonarFilePath%\sonar-runner-2.4\conf\sonar-runner.properties
echo sonar.login=%username% >> %sonarFilePath%\sonar-runner-2.4\conf\sonar-runner.properties
echo sonar.password=%pass% >> %sonarFilePath%\sonar-runner-2.4\conf\sonar-runner.properties


echo %PATH%;%sonarFilePath%\sonar-runner-2.4\bin >> configSonar.xml

echo Enter the location of Accurev Code base including CODE folder
set /p accurevFilePath=
echo accurevFilePath = %accurevFilePath% >> configSonar.xml


echo # must be unique in a given SonarQube instance > %accurevFilePath%/sonar-project.properties
echo # must be unique in a given SonarQube instance
set /p sonarProjectKey=
echo sonar.projectKey=%sonarProjectKey%>> %accurevFilePath%/sonar-project.properties
echo # this is the name displayed in the SonarQube UI >> %accurevFilePath%/sonar-project.properties
echo sonar.projectName=%sonarProjectKey%>> %accurevFilePath%/sonar-project.properties
echo sonar.projectVersion=10/31/2016>>%accurevFilePath%/sonar-project.properties

echo Enter the module Name, Enter using a space if more than one module should be scanned
set /p sonarModules=
echo sonar.modules=%sonarModules% >>%accurevFilePath%/sonar-project.properties


for %%A in (%sonarModules%) do (
echo Enter the file paths for %%A module
set /p sonarSources=
echo %%A.sonar.sources=!sonarSources!>> %accurevFilePath%/sonar-project.properties
)

echo #sonar.sourceEncoding=windows-1252>> %accurevFilePath%/sonar-project.properties
echo sonar.report.login=username>> %accurevFilePath%/sonar-project.properties
echo sonar.report.password=password>> %accurevFilePath%/sonar-project.properties
echo sonar.issuesReport.html.enable=true>> %accurevFilePath%/sonar-project.properties
echo sonar.issuesReport.console.enable=true>> %accurevFilePath%/sonar-project.properties


cd %accurevFilePath% 
sonar-runner -Dsonar.analysis.mode=incremental
pause 

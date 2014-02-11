@echo off
cls
echo.
echo   ******************************************************
echo   *                                                    *
echo   *           ADB-Screenshot from Recovery             *
echo   *                                                    *
echo   *     Original idea: Kyan He                         *
echo   * code.google.com/p/android-fb2png                   *
echo   *                                                    *
echo   *     Script: Whiskey103                             *
echo   * forum.xda-developers.com/showthread.php?p=40260716 *
echo   *                                                    *
echo   *     Script update: Korbeny                         *
echo   *                                                    *
echo   *     ADB version: 1.0.31  (August 2013)             *
echo   *                                                    *
echo   *     Instructions:                                  *
echo   *       - Boot into recovery                         *
echo   *       - Plug in USB cable                          *
echo   *         When ready press a key to continue         *
echo   *                                                    *
echo   ******************************************************
echo.
pause
cls
adb devices
goto option
:option
cls
echo.
echo.
echo.
echo   1.- Make a screenshot
echo   2.- Exit
echo.
set /p choice=Type the number of your choice  
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto screenshot
if '%choice%'=='2' goto exit
cls
echo.
echo.
echo.
echo    "%choice%" is not a valid option. Please try again
echo.
echo.
pause
goto option
:screenshot
cls
adb shell mount /data
adb push fb2png /data/local/
adb push dump /data/local/
adb shell chmod 755 /data/local/fb2png
adb shell chmod 755 /data/local/dump
adb shell /data/local/dump
adb pull /data/local/ScreenShots
adb shell rm /data/local/fb2png
adb shell rm /data/local/dump
adb shell rm -r /data/local/ScreenShots
echo.
echo.
echo   ******************************************************
echo   *                                                    *
echo   * The screenshot was taken successfully              *
echo   *                                                    *
echo   ******************************************************
echo.
echo.
adb shell sync
adb shell umount /data
pause
goto option
:exit
cls
echo.
echo.
echo.
echo   ******************************************************
echo   *                                                    *
echo   * The screenshots are stored in the ADB folder       *
echo   * named as Screenshot_date_time.png                  *
echo   *                                                    *
echo   ******************************************************
echo.
echo.
pause
exit
#!/bin/bash
clear
echo ""
echo "  ******************************************************"
echo "  *                                                    *"
echo "  *      ADB-Screenshot from Recovery                  *"
echo "  *                                                    *"
echo "  *     Original idea: Kyan He                         *"
echo "  * code.google.com/p/android-fb2png                   *"
echo "  *                                                    *"
echo "  *     Script Windows: Whiskey103                     *"
echo "  * forum.xda-developers.com/showthread.php?p=40260716 *"
echo "  *                                                    *"
echo "  *     Script Windows update: Korbeny                 *"
echo "  *     Script Linux/MacOSX: John Hu                   *"
echo "  * http://john.hu/android-recovery-screenshot         *"
echo "  *                                                    *"
echo "  *     ADB version: 1.0.31  (August 2013)             *"
echo "  *                                                    *"
echo "  *     Instructions:                                  *"
echo "  *  - Boot into recovery                              *"
echo "  *  - Plug in USB cable                               *"
echo "  *    When ready press a key to continue              *"
echo "  *                                                    *"
echo "  ******************************************************"
echo ""
read -p "  Press any key to continue" PAUSE
DEVICE=$(adb devices|grep recovery)
if [ "$DEVICE" == "" ]; then
  echo "  Please boot into recovery and plug in USB cable."
  exit -1
fi

function takeScreenshot() {
  OS=$(uname)
  if [ "$OS" == "Darwin" ]; then
    ADBEXEC="./adb.osx"
  else
    ADBEXEC="./adb-linux"
  fi
  $ADBEXEC shell mount /data
  $ADBEXEC push fb2png /data/local
  $ADBEXEC push dump /data/local
  $ADBEXEC shell chmod 755 /data/local/fb2png
  $ADBEXEC shell chmod 755 /data/local/dump
  $ADBEXEC shell /data/local/dump
  $ADBEXEC pull /data/local/ScreenShots
  $ADBEXEC shell rm /data/local/fb2png
  $ADBEXEC shell rm /data/local/dump
  $ADBEXEC shell rm -r /data/local/ScreenShots
  echo ""
  echo ""
  echo "  ******************************************************"
  echo "  *                                                    *"
  echo "  *    The screenshot was taken successfully           *"
  echo "  *                                                    *"
  echo "  ******************************************************"
  $ADBEXEC shell sync
  $ADBEXEC shell umount /data
}

USERINPUT="-"
until [ "$USERINPUT" == "2" ]
do
  clear
  echo ""
  echo ""
  echo ""
  echo "  1.- Make a screenshot"
  echo "  2.- Exit"
  read -p "Your choice: " USERINPUT
  if [ "$USERINPUT" == "1" ]; then
    takeScreenshot;
  fi
done

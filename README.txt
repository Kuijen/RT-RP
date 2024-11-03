Steps to install and run it:

1. Make sure USB Debugging is enabled on your headset via Developer Options

2. Connect your headset to your computer and run RTRP, a command prompt should pop-up and it should say "Performing Streamed Install", after that you should get a window pop-up on your headset asking for permission, press accept.

3. If "ERROR Main: Execution error: Command adb ["shell", "dumpsys", "package", "com.genymobile.gnirehtet"] returned with value 1" or "'java' is not recognized as an internal or external command," comes up it usually either means that your device is not connected, that there is something wrong with the START.cmd script or that the Java Runtime got borked. In that case a reinstall would probably fix it.

4. Comment out Virtual desktop in the START.cmd if you do not want Virtual Desktop to start alongside RTRP by adding (::) in front of the line.

5. Yes lag spikes are common, it is what it is.

6. If you have issues with it disconnecting (Client #0 Disconnected) try creating a .bat file in your gnirehtet file containing gnirehtet run -d 1.1.1.1 and run it from there.



START.cmd Copyright 2024 by KUIJEN is licensed under GNU General Public Licence Version 3.0 https://www.gnu.org/licenses/gpl-3.0.txt

-Yours Truly-
   KUIJEN
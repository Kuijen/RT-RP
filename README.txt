Steps to install and run it:

1. Make sure USB Debugging is enabled on your headset via Developer Options

2. Connect your headset to your computer and run RTRP, a command prompt should pop-up and it should say "Performing Streamed Install", after that you should get a window pop-up on your headset asking for permission, press accept.

3. If "ERROR Main: Execution error: Command adb ["shell", "dumpsys", "package", "com.genymobile.gnirehtet"] returned with value 1" or "'java' is not recognized as an internal or external command," comes up it usually either means that your device is not connected, that there is something wrong with the START.cmd script or that the Java Runtime got borked. In that case a reinstall would probably fix it.

4. There is a config file called config.txt inside the installation folder where you can customize what apps will launch.

5. If you have issues with it disconnecting (Client #0 Disconnected) try creating a .bat file in your gnirehtet file containing gnirehtet run -d 1.1.1.1 and run it from there.

6. You can change which apps are allowed to launch by changing true to false and vice versa in "RT-RP Config.txt" inside your Documents folder, you can also change their install directories in the same file.

7. Using HEVC/HEVC 10-Bit and possibly AV1 is recommended for Virtual Desktop to avoid stutters.

8. Disabling unneeded launch options does speed up the script ever so slightly.



-Yours Truly-
   KUIJEN
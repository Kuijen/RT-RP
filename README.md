# RT-RP
A wrapper made for [Gnirehtet](https://github.com/Genymobile/gnirehtet) to streamline usage for android based VR headsets

<h1><strong>What is it?</strong><br></h1>
RT-RP, which stands for Reverse Tethering RePack, is primarily designed as a wrapper for Gnirehtet, a program that enables reverse tethering through ADB for Android devices. RT-RP adds extra features for greater ease of use and convenience, tailored specifically to work better with Android based VR headsets.
<br></br>

![RTRP HQ](https://github.com/user-attachments/assets/ba916d9f-80a4-4758-947f-119c01e871a0)

<h1><strong>Features:</strong><br></h1>
Launches SlimeVR Server, Amethyst and Virtual Desktop Streamer alongside Gnirehtet for reverse tethering to an android based VR headset in order to use wifi only applications such as Virtual Desktop with a USB cable.


<p></p>
<h1><strong>Usage:</strong></h1>

1. Make sure USB Debugging is enabled on your headset via Developer Options!

2. Connect your headset to your computer and run RT-RP, a command prompt should pop-up and it should say "Performing Streamed Install", after that you should get a window pop-up on your headset asking for permission, press accept.

3. If "ERROR Main: Execution error: Command adb ["shell", "dumpsys", "package", "com.genymobile.gnirehtet"] returned with value 1" or "'java' is not recognized as an internal or external command," comes up it usually either means that your headset is not connected, that there is something wrong with the START.cmd script or that the Java Runtime got borked. In that case a reinstall would probably fix it.

4. Yes lag spikes are common, it is what it is.

5. If you have issues with it disconnecting (Client #0 Disconnected) try creating a .bat file in your gnirehtet file containing gnirehtet run -d 1.1.1.1 and run it from there.


<h1 style="font-size:300%;"></h1>

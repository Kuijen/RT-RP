# RT-RP
A wrapper made for [Gnirehtet](https://github.com/Genymobile/gnirehtet) to streamline usage for Android based VR headsets

<h1><strong>What is it?</strong><br></h1>
RT-RP, which stands for Reverse Tethering RePack, is primarily designed as a wrapper for Gnirehtet, a program that enables reverse tethering through ADB for Android devices. RT-RP adds extra features for greater ease of use and convenience, tailored specifically to work better with Android based VR headsets.
<br></br>

<img width="2119" height="1355" alt="Screenshot 2025-07-13 232006" src="https://github.com/user-attachments/assets/7d977871-49ea-4387-86b4-78f693fa0aee" />



<h1><strong>Features:</strong><br></h1>
Launches SteamVR, SlimeVR Server, Amethyst, VRCFT, Virtual Desktop Streamer, ALVR, Vive Hub and VRCX alongside Gnirehtet for reverse tethering to an android based VR headset in order to use wifi only applications such as Virtual Desktop with a USB cable.

<h1><strong>Usage:</strong></h1>

1. Make sure that Developer Mode is enabled and that the USB Debugging prompt inside the headset is accepted!

2. Connect your headset to your computer and run RT-RP, a command prompt should pop-up and it should say "Performing Streamed Install", after that you should get a window pop-up on your headset asking for permission, press accept.

3. if you see ports opeining and closing in the commands promt it means you successfully connected to your PC and you can now launch into whatever app you want to use it for.

4. If "ERROR Main: Execution error: Command adb ["shell", "dumpsys", "package", "com.genymobile.gnirehtet"] returned with value 1" it just means that you need to connect your headset and try again, make sure developer mode is enabled on your headset.

5. if you see "'java' is not recognized as an internal or external command," comes up it usually means that the Java Runtime got borked. In that case a reinstall would probably fix it, alternatively you can use the runtime installer inside RT-RP's install directory.

6. You can change which apps are allowed to launch by changing true to false and vice versa in "RT-RP Config.txt" inside your Documents folder, you can also change their install directories in the same file.

7. Using HEVC/HEVC 10-Bit and possibly AV1 is recommended for Virtual Desktop to avoid stutters.

8. Disabling unneeded launch options does speed up the script ever so slightly. 

<h1><strong>Using the Source files:</strong></h1>

The only files you actually need are START.cmd, [cmdmp3](https://github.com/jimlawless/cmdmp3),High Priority.CMD and config.txt, everything else comes from the Java version of [Gnirehtet](https://github.com/Genymobile/gnirehtet).<br> Just put the files into the same folder as Gnirehtet and run START.cmd to launch the script.
(more detailed instructions coming eventually)

The [NSIS](https://nsis.sourceforge.io/Main_Page) script is only needed if you want to bundle it into an installer, make sure that you change the user directory inside the script!


<h1 style="font-size:300%;"></h1>

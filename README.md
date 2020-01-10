# IAmRespondingKiosk
Automate and display an IAmResponding dashboard with a RaspberryPi

## Section 0 - PreReqs & Considerations
The following guide was made with a Raspberry Pi Zero W, which can be bought between $20 and $30 on Amazon. The I Am Responding dashboard is a bit laggy on this equipment when you have scrolling involved, but otherwise does a pretty good job. You will also need an microSD card of 8gigs or more, and the right stuff to connect up your RaspberryPi to a monitor (HDMI Cable)

## Section 1 - Installing NOOBS on your RaspberryPi
[Download and Install NOOBS on your RaspberryPi](https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up)

Upon first boot, select and install Raspbian Desktop

## Section 2 - Setup SSH access
On your newly setup RasberryPi, open up a terminal and type `sudo raspi-config`. Using the arrow keys, navigate to *Interface Options* then *SSH*. Select *Yes* when asked if you would like to enable SSH server. Select *Finish* to exit. You will need SSH access to this machine once we have fully set this up. You IP address can be obtained via the `ip addr` command.
  
## Section 3 - Chromium Setup
Either via the terminal on the RaspberryPi or SSH, we need to install Chromium (and update our repo's to ensure we have the latest versions):

    sudo apt update && sudo apt install -y chromium-browser
    
Start Chromium and navigate to `chrome://extensions/`. Delete all extensions, then install [IARInjection](https://chrome.google.com/webstore/detail/iar-injection/oapdkapkhmpljfoaefgihjhgibhcmcda?hl=en-US). Configure the extension with your IAR login details.

## Section 3 - Package & Final Setup
Either via the terminal on the RaspberryPi or SSH, we need to set some stuff up. To install the packages we need:

    sudo apt install -y matchbox-window-manager nodm

Set up nodm
Edit /etc/default/nodm with your favorite text editor, or use nano:

    sudo nano /etc/default/nodm
    
When in nano, type or copy in the following:

    NODM_ENABLED=true
    NODM_USER=pi

To exit nano [Ctrl]+[x], hitting [y] when asking if it wants you to save.

Please note that if you changed your username from 'pi' during setup, you'll need to change it here. I'm assuming you didn't change it.

Next, we need to tell the Raspberry Pi to launch the browser at boot and disable some of the power settings as this is a non-interactive display board.

To do this, create a new file called '.xsession' in /home/pi (/home/pi/.xsession). Save the following to it: 

    #!/bin/bash
    xset -dpms     # disable DPMS (Energy Star) features.
    xset s off       # disable screen saver
    xset s noblank # don't blank the video device
    chromium-browser --kiosk --app www.iamresponding.com/v3/Pages/Default.aspx & exec matchbox-window-manager
    
To exit nano [Ctrl]+[x], hitting [y] when asking if it wants you to save.
    
You should now be able to exit and test out your setup by rebooting the machine:

    sudo shutdown -r now
    
When you computer reboots, it should launch into the dashboard for I Am Responding automatically.

## References
### Section 1
https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up

## Section 2
https://chrome.google.com/webstore/detail/iar-injection/oapdkapkhmpljfoaefgihjhgibhcmcda?hl=en-US

### Section 3
https://www.raspberrypi.org/forums/viewtopic.php?p=994796#p994796

## To Do
[ ] Need to find a way to get rid of mouse pointer

[ ] Auto scheduled reboot

[ ] Auto scheduled updates

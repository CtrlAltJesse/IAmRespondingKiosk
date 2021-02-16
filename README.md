# IAmRespondingKiosk
Automate and display an IAmResponding dashboard with a RaspberryPi

Has your existing dashboard broke with IAR's new cookie acceptance screen? Follow the [fix guide here](cookieacceptfix.md).

## Section 0 - PreReqs & Considerations
The following guide was made with a Raspberry Pi Zero W, which can be bought between $20 and $30 on Amazon, but should work well with any model Pi. The I Am Responding dashboard is a bit laggy on this equipment when you have scrolling involved, but otherwise does a pretty good job. You will also need an microSD card of 8gigs or more, and the right stuff to connect up your RaspberryPi to a monitor (like a HDMI Cable).

You should be able to display other websites with minimal modifications of the below instructions.

## Section 1 - Installing NOOBS on your RaspberryPi
[Download and Install NOOBS on your RaspberryPi](https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up)

Upon first boot, select and install Raspbian Desktop

## Section 2 - Setup SSH access
On your newly setup RasberryPi, open up a terminal and type `sudo raspi-config`. Using the arrow keys, navigate to *Interface Options* then *SSH*. Select *Yes* when asked if you would like to enable SSH server. Select *Finish* to exit. You will need SSH access to this machine once we have fully set this up. You IP address can be obtained via the `ip addr` command.
  
## Section 3 - Chromium Setup
Either via the terminal on the RaspberryPi or SSH, we need to install Chromium (and update our repo's to ensure we have the latest versions):

    sudo apt update && sudo apt install -y chromium-browser
    
Start Chromium and navigate to `chrome://extensions/`. Delete all extensions, then install [IARInjection](https://chrome.google.com/webstore/detail/iar-injection/oapdkapkhmpljfoaefgihjhgibhcmcda?hl=en-US) & [TamperMonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?hl=en). 

For IARInjection, Configure the extension with your IAR login details.

For TamperMonkey, click on the puzzle piece icon to the right of the URL bar. Then click `Tampermonkey` > `Create a new script`.

Delete everything in the `New Userscript` box, and replace with the contents of the [CookieAccept](cookieaccept) file in this directly. At this point, you will likely have to open up a new tab and search for this GitHub repo on the RasPi itself as it is way to much to hand copy.
*Note: The simpliest search term I can come up with is 'github ctrlaltjesse iar' to get right to this repo.*

Once copied over, hit [Ctrl] + [S] to save the document.

To test, navigate to `dashboard.iamresponding.com`, you should now be logged into your dashboard with no manual steps needed.

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
    chromium-browser --kiosk --app https://www.iamresponding.com/v3/Pages/memberlogin.aspx & exec matchbox-window-manager
    
To exit nano [Ctrl]+[x], hitting [y] when asking if it wants you to save.
    
You should now be able to exit and test out your setup by rebooting the machine:

    sudo shutdown -r now
    
When you computer reboots, it should launch into the dashboard for I Am Responding automatically.

## Section 4 - Other things you may want to do
### Automatic Reboot
If you are in the IAmResponding browser window, hit [Ctrl]+[Alt]+[F1] to get to a console.

Navigate to crontab, which is where you tell your Pi to run commands at a specified time:

    sudo nano /etc/crontab
    
And paste in the following command: (note - `0 2 * * 2` effectively tells the machine `Tuesday at 2am`. [Crontab.guru](https://crontab.guru/) is a great resource to find another time.

    0 2 * * 2 root reboot
    
To exit nano [Ctrl]+[x], hitting [y] when asking if it wants you to save.

### Automated Updates
Updates are a good idea to keep the machine running with modern code and security patches. To have updates run automatically, install and configure `Unattended-Upgrades`

    sudo apt install -y unattended-upgrades
    
Then configure the package:

    sudo dpkg-reconfigure --priority=low unattended-upgrades
    
Highlight and hit [Yes] on the dialoge that comes up.

### Get rid of the mouse pointer
To get rid of the mouse pointer, simply install `Unclutter`

    sudo apt install -y unclutter

You're done!

## References
### Section 1
https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up

### Section 2
https://chrome.google.com/webstore/detail/iar-injection/oapdkapkhmpljfoaefgihjhgibhcmcda?hl=en-US

### Section 3
https://www.raspberrypi.org/forums/viewtopic.php?p=994796#p994796

### Section 4
https://www.raspberrypi.org/forums/viewtopic.php?t=126106

https://crontab.guru/#0_2_*_*_2

https://help.ubuntu.com/community/AutomaticSecurityUpdates

## To Do
[X] Need to find a way to get rid of mouse pointer

[X] Auto scheduled reboot

[X] Auto scheduled updates

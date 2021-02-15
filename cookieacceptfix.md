# Instructions to Fix your Kiosk and Accept Cookies
So your existing kiosk broke when I Am Responding rolled out their 'Accept Cookies' box, huh? No worries, follow the guide below for a fix!

If anyone knows of an easier fix, please feel free to let me know.

## Section 1 - Get To A Terminal
Connect a mouse and keyboard to your system. Once connected, hit [Ctrl] + [Alt] + [F1] at the same time. This should bring you to a terminal prompt.

## Section 2 - Run Terminal Commands
*If you have installed `unclutter`, run this command. If not, skip it.*

    sudo apt remove unclutter -y

This will remove the app that is currently hiding your mouse when you start the computer. You will need your mouse to make some changes in chrome.

Now, you will need to start Chromium in normal mode to make some changes. First run the command:

    nano /home/pi/.xsession

Once in Nano, move your cursor to the last line and insert a `#` after `chromium-browser` so it looks like this:

    chromium-browser #--kiosk --app https://www.iamresponding.com/v3/Pages/memberlogin.aspx & exec matchbox-window-manager

This will comment out all the special options and run Chromium in normal mode.

To exit nano [Ctrl]+[x], hitting [y] when asking if it wants you to save.
    
You should now be able to exit and reboot your machine to launch the browser:

    sudo shutdown -r now    

When you computer reboots, it should launch into a full version of Chromium.

## Section 3 - Install TamperMonkey & the Cookie Accept Script
Once rebooted, you should be able to enter URLs in Chromium.

Type in `chrome://extentions` and hit [Enter]. This should bring up all of the extentions you have installed, and you should see IARInjection here.

In the upper left corner on the blue bar, there should be three bars near the word `Extentions`. Click on that to open to open a side menu. On the bottom, click on `Open Chrome Web Store`.

In the Web Store, search and install `TamperMonkey`

Once installed, click on the puzzle piece icon to the right of the URL bar. Then click `Tampermonkey` > `Create a new script`.

Delete everything in the `New Userscript` box, and replace with the contents of the [CookieAccept](cookieaccept) file in this directly. At this point, you will likely have to open up a new tab and search for this GitHub repo on the RasPi itself as it is way to much to hand copy.
*Note: The simpliest search term I can come up with is 'github ctrlaltjesse iar' to get right to this repo.*

Once copied over, hit [Ctrl] + [S] to save the document.

To test, navigate to `dashboard.iamresponding.com`, you should now be logged into your dashboard with no manual steps needed.

## Section 4 - Back To The Terminal
Once you have completed your successful test, go back to a terminal by hitting [Ctrl] + [Alt] + [F1] at the same time.

Go back to your .xsession file and remove the '#' that you previously put there:

    nano /home/pi/.xsession

The new line should look like this:

    chromium-browser --kiosk --app https://www.iamresponding.com/v3/Pages/memberlogin.aspx & exec matchbox-window-manager

To exit nano [Ctrl]+[x], hitting [y] when asking if it wants you to save.

*If you have previously removed `unclutter`, make sure you have reinstalled it:*

    sudo apt install unclutter -y

You should now be able to exit and reboot your machine to launch the browser

    sudo shutdown -r now    

When you computer reboots, it should launch back into kiosk mode and resolve the cookie issue.
# You're done! :-)

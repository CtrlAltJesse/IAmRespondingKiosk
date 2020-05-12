#!/bin/bash
xset -dpms     # disable DPMS (Energy Star) features.
xset s off     # disable screen saver
xset s noblank # don't blank the video device
chromium-browser --kiosk www.iamresponding.com/v3/Pages/Default.aspx & exec matchbox-window-manager

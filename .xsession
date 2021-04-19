#!/bin/bash
xset -dpms     # disable DPMS (Energy Star) features.
xset s off     # disable screen saver
xset s noblank # don't blank the video device
chromium-browser --kiosk https://dashboard.iamresponding.com & exec matchbox-window-manager

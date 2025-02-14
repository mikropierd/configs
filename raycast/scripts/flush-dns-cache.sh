#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Flush DNS Cache
# @raycast.mode compact

# Documentation:
# @raycast.description This script flushes the DNS cache on macOS
# @raycast.author r4ngn
# @raycast.authorURL https://raycast.com/r4ngn

# Prompt for sudo password upfront
sudo -v

# Flush the DNS cache
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Notify the user
echo "DNS cache flushed successfully."

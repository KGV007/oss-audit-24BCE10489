#!/bin/bash
# Script 1: System Identity Report
# Author: Kevin George Varghese | Course: Open Source Software

# -----------------------------------------------
# --- Variables ---
# -----------------------------------------------
STUDENT_NAME="Your Name"           # Fill in your name
SOFTWARE_CHOICE="Apache (httpd)"   # Fill in your chosen software

# --- Gather system info using command substitution $() ---
KERNEL=$(uname -r)                          # Kernel version
USER_NAME=$(whoami)                         # Current logged-in user
HOME_DIR=$(eval echo "~$USER_NAME")        # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y %H:%M:%S')  # Formatted date and time

# --- Get Linux distribution name ---
# /etc/os-release is a standard file present on most modern Linux distros
if [ -f /etc/os-release ]; then
    DISTRO=$(grep -m1 "^PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"
fi

# --- Determine the OS license ---
# Most major Linux distros are licensed under the GNU GPL
OS_LICENSE="GNU General Public License v2 (GPLv2)"

# -----------------------------------------------
# --- Display welcome screen ---
# -----------------------------------------------
echo "=================================================="
echo "       Open Source Audit — $STUDENT_NAME          "
echo "=================================================="
echo ""
echo "  Software Under Review : $SOFTWARE_CHOICE"
echo "--------------------------------------------------"
echo "  Distribution  : $DISTRO"
echo "  Kernel Version: $KERNEL"
echo "  Logged-in User: $USER_NAME"
echo "  Home Directory: $HOME_DIR"
echo "  System Uptime : $UPTIME"
echo "  Date & Time   : $CURRENT_DATE"
echo "--------------------------------------------------"
echo "  License Info  : This OS is covered under the"
echo "                  $OS_LICENSE"
echo "=================================================="
echo ""
echo "  Welcome to the Open Source Audit Tool!"
echo "  Exploring freedom, transparency, and community."
echo "=================================================="

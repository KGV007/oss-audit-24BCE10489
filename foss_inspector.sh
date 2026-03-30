#!/bin/bash
# Script 2: FOSS Package Inspector

# -----------------------------------------------
# --- Package to inspect ---
# -----------------------------------------------
PACKAGE="httpd"   # Change to your chosen package: httpd, mysql, vlc, firefox, etc.

echo "=================================================="
echo "        FOSS Package Inspector                    "
echo "=================================================="
echo ""

# -----------------------------------------------
# --- Check if the package is installed ---
# Uses rpm for Red Hat/Fedora-based systems;
# falls back to dpkg for Debian/Ubuntu-based systems
# -----------------------------------------------
if command -v rpm &>/dev/null; then
    # --- RPM-based system (Fedora, RHEL, CentOS) ---
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  [✔] '$PACKAGE' is INSTALLED on this system."
        echo ""
        echo "  --- Package Details ---"
        # Extract Version, License, and Summary fields using grep with extended regex
        rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary'
    else
        echo "  [✘] '$PACKAGE' is NOT installed on this system."
        echo "  Tip: Install it with: sudo dnf install $PACKAGE"
    fi
elif command -v dpkg &>/dev/null; then
    # --- DEB-based system (Ubuntu, Debian) ---
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "  [✔] '$PACKAGE' is INSTALLED on this system."
        echo ""
        echo "  --- Package Details ---"
        # Show version and description from dpkg
        dpkg -l "$PACKAGE" | grep "^ii" | awk '{print "  Version : "$3"\n  Package : "$2"\n  Desc    : "$5}'
    else
        echo "  [✘] '$PACKAGE' is NOT installed on this system."
        echo "  Tip: Install it with: sudo apt install $PACKAGE"
    fi
else
    echo "  [!] Cannot determine package manager. Please check manually."
fi

echo ""
echo "=================================================="
echo "        Open Source Philosophy Notes              "
echo "=================================================="
echo ""

# -----------------------------------------------
# --- Case statement: print a philosophy note ---
# based on which package is being inspected
# -----------------------------------------------
case $PACKAGE in
    httpd)
        echo "  Apache HTTP Server:"
        echo "  The web server that built the open internet."
        echo "  Since 1995, Apache has powered millions of websites"
        echo "  entirely through open collaboration."
        ;;
    mysql)
        echo "  MySQL:"
        echo "  Open source at the heart of millions of apps."
        echo "  MySQL proves that free software can compete with"
        echo "  the biggest commercial databases in the world."
        ;;
    firefox)
        echo "  Mozilla Firefox:"
        echo "  The browser that champions user privacy and open standards."
        echo "  Firefox reminds us that the web belongs to everyone,"
        echo "  not just corporations."
        ;;
    vlc)
        echo "  VLC Media Player:"
        echo "  The universal player — free, open, and format-agnostic."
        echo "  VLC shows that open source can out-feature proprietary"
        echo "  software in everyday tools."
        ;;
    git)
        echo "  Git:"
        echo "  The backbone of modern open source collaboration."
        echo "  Git's distributed model trusts every contributor equally,"
        echo "  embodying the spirit of decentralised freedom."
        ;;
    vim | nano | emacs)
        echo "  $PACKAGE — A Text Editor:"
        echo "  The editor wars are proof that open source thrives on"
        echo "  diversity of opinion. Every editor here is free, powerful,"
        echo "  and shaped by its community."
        ;;
    *)
        echo "  $PACKAGE:"
        echo "  Every open source project, large or small, represents"
        echo "  a belief that software should be free to use, study,"
        echo "  modify, and share. This package carries that spirit."
        ;;
esac

echo ""
echo "=================================================="

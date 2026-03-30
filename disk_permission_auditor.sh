#!/bin/bash
# Script 3: Disk and Permission Auditor

# -----------------------------------------------
# --- List of important system directories ---
# -----------------------------------------------
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")

# --- Your chosen software's config directory ---
# Change this to match your software (e.g. /etc/httpd, /etc/mysql, /etc/nginx)
SOFTWARE_CONFIG_DIR="/etc/httpd"
SOFTWARE_NAME="Apache (httpd)"

echo "=================================================="
echo "         Directory & Permission Audit Report      "
echo "=================================================="
printf "%-20s %-30s %-10s\n" "Directory" "Permissions (perms owner group)" "Size"
echo "--------------------------------------------------"

# -----------------------------------------------
# --- for loop: iterate over each directory ---
# -----------------------------------------------
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, group using awk on ls -ld output
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # Get human-readable size; suppress permission errors with 2>/dev/null
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted row
        printf "%-20s %-30s %-10s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        echo "  [!] $DIR does not exist on this system."
    fi
done

echo "--------------------------------------------------"
echo ""

# -----------------------------------------------
# --- Check the software's config directory ---
# -----------------------------------------------
echo "=================================================="
echo "   Software Config Directory Check: $SOFTWARE_NAME"
echo "=================================================="
echo ""

if [ -d "$SOFTWARE_CONFIG_DIR" ]; then
    # Directory exists — show its permissions
    CONFIG_PERMS=$(ls -ld "$SOFTWARE_CONFIG_DIR" | awk '{print $1, $3, $4}')
    CONFIG_SIZE=$(du -sh "$SOFTWARE_CONFIG_DIR" 2>/dev/null | cut -f1)

    echo "  [✔] Config directory found: $SOFTWARE_CONFIG_DIR"
    echo ""
    echo "  Permissions : $CONFIG_PERMS"
    echo "  Size        : ${CONFIG_SIZE:-N/A}"
    echo ""

    # Warn if config directory is world-writable (security concern)
    WORLD_WRITE=$(ls -ld "$SOFTWARE_CONFIG_DIR" | cut -c9)
    if [ "$WORLD_WRITE" = "w" ]; then
        echo "  [⚠] WARNING: Config directory is world-writable! Security risk."
    else
        echo "  [✔] Permissions look secure (not world-writable)."
    fi
else
    echo "  [✘] Config directory '$SOFTWARE_CONFIG_DIR' was NOT found."
    echo "      This may mean $SOFTWARE_NAME is not installed,"
    echo "      or its config lives elsewhere on this system."
fi

echo ""
echo "=================================================="
echo "  Audit complete."
echo "=================================================="

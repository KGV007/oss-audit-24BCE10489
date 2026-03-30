#!/bin/bash
# Script 4: Log File Analyzer
# Usage: ./log_analyzer.sh/var/log/messages

# -----------------------------------------------
# --- Command-line arguments ---
# $1 = log file path, $2 = optional keyword (default: "error")
# -----------------------------------------------
LOGFILE=$1
KEYWORD=${2:-"error"}    # Default keyword is 'error' if none provided
COUNT=0                  # Counter variable to track keyword matches
MAX_RETRIES=3            # Maximum retry attempts if file is empty

# -----------------------------------------------
# --- Validate the log file argument ---
# -----------------------------------------------
if [ -z "$LOGFILE" ]; then
    echo "  [!] Usage: $0 <logfile> [keyword]"
    echo "      Example: $0 /var/log/syslog error"
    exit 1
fi

if [ ! -f "$LOGFILE" ]; then
    echo "  [✘] Error: File '$LOGFILE' not found."
    exit 1
fi

echo "=================================================="
echo "            Log File Analyzer                     "
echo "=================================================="
echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD'"
echo "--------------------------------------------------"
echo ""

# -----------------------------------------------
# --- do-while style retry loop ---
# Retries if the file is empty, up to MAX_RETRIES times
# Bash doesn't have do-while, so we simulate it with
# a while loop that checks the condition at the bottom
# -----------------------------------------------
ATTEMPT=0
while true; do
    ATTEMPT=$((ATTEMPT + 1))

    if [ -s "$LOGFILE" ]; then
        # File is non-empty — break out of retry loop
        echo "  [✔] File found and non-empty. Proceeding with analysis..."
        echo ""
        break
    else
        echo "  [!] Attempt $ATTEMPT/$MAX_RETRIES: '$LOGFILE' is empty."
        if [ "$ATTEMPT" -ge "$MAX_RETRIES" ]; then
            echo "  [✘] File is still empty after $MAX_RETRIES attempts. Exiting."
            exit 1
        fi
        echo "      Retrying in 2 seconds..."
        sleep 2
    fi
done

# -----------------------------------------------
# --- while read loop: read file line by line ---
# IFS= prevents trimming of leading/trailing whitespace
# -r prevents backslash interpretation
# -----------------------------------------------
while IFS= read -r LINE; do
    # if-then: check if current line contains the keyword (case-insensitive with -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment counter for each match
    fi
done < "$LOGFILE"

# -----------------------------------------------
# --- Summary output ---
# -----------------------------------------------
echo "  --- Analysis Summary ---"
echo "  Keyword '$KEYWORD' found $COUNT time(s) in $LOGFILE"
echo ""

# -----------------------------------------------
# --- Print the last 5 matching lines ---
# Uses grep to filter matches and tail to get last 5
# -----------------------------------------------
echo "  --- Last 5 Matching Lines ---"
LAST5=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -z "$LAST5" ]; then
    echo "  (No matching lines found for '$KEYWORD')"
else
    echo "$LAST5" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
fi

echo ""
echo "=================================================="
echo "  Analysis complete."
echo "=================================================="

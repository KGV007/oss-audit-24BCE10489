#!/bin/bash
# Script 5: Open Source Manifesto Generator

echo "=================================================="
echo "       Open Source Manifesto Generator            "
echo "=================================================="
echo ""
echo "  Answer three questions to generate your personal"
echo "  open source philosophy statement."
echo ""
echo "--------------------------------------------------"

# -----------------------------------------------
# --- read: interactively collect user input ---
# -p displays an inline prompt before waiting for input
# -----------------------------------------------
read -p "  1. Name one open-source tool you use every day: " TOOL
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
read -p "  3. Name one thing you would build and share freely: " BUILD

echo ""

# -----------------------------------------------
# --- Get current user and date ---
# -----------------------------------------------
AUTHOR=$(whoami)
DATE=$(date '+%d %B %Y')

# -----------------------------------------------
# --- Define the output filename ---
# String concatenation: variable + literal string
# -----------------------------------------------
OUTPUT="manifesto_${AUTHOR}.txt"

# -----------------------------------------------
# --- Compose and write the manifesto to file ---
# > creates/overwrites the file (first line)
# >> appends each subsequent line to the file
# -----------------------------------------------

# Write the header first (overwrite if exists)
echo "==================================================" > "$OUTPUT"
echo "         MY OPEN SOURCE MANIFESTO                " >> "$OUTPUT"
echo "  Author : $AUTHOR   |   Date : $DATE           " >> "$OUTPUT"
echo "==================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# -----------------------------------------------
# --- String concatenation to build the paragraph ---
# Variables $TOOL, $FREEDOM, $BUILD are substituted in
# -----------------------------------------------
echo "  Every day I reach for $TOOL — not because I have to," >> "$OUTPUT"
echo "  but because I choose to. It was built by people who" >> "$OUTPUT"
echo "  believed software should be shared, not hoarded." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  To me, freedom means $FREEDOM. That single idea is at" >> "$OUTPUT"
echo "  the heart of everything the open source movement stands" >> "$OUTPUT"
echo "  for. When code is free, knowledge grows without limits." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  One day, I will build $BUILD — and I will share it freely." >> "$OUTPUT"
echo "  Because the best ideas don't shrink when you give them away;" >> "$OUTPUT"
echo "  they multiply. That is the promise of open source." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  I believe in transparent collaboration, peer review," >> "$OUTPUT"
echo "  and the power of community. I carry these values forward." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  — $AUTHOR, $DATE" >> "$OUTPUT"
echo "==================================================" >> "$OUTPUT"

# -----------------------------------------------
# --- Confirm and display the saved manifesto ---
# -----------------------------------------------
echo "--------------------------------------------------"
echo "  [✔] Manifesto saved to: $OUTPUT"
echo "--------------------------------------------------"
echo ""

# Display the manifesto to the terminal
cat "$OUTPUT"

echo ""
echo "=================================================="
echo "  Share your manifesto. Open source lives in      "
echo "  the sharing.                                    "
echo "=================================================="

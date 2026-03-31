#!/bin/bash
# =============================================================================
# Script 5: Open Source Manifesto Generator
# Author: Abdul Samad Khan | Course: Open Source Software | VITyarthi
# Chosen Software: Python (PSF License)
# Concepts: read -p for interactive input, string concatenation, > and >>
#           file redirection, date, whoami, cat, while validation loop,
#           alias concept (demonstrated in comments), arrays for quotes
# =============================================================================

# ── Alias concept (comment demonstration) ─────────────────────────────────────
# Aliases are shell shortcuts defined with: alias name='command'
# In a live session you could type: alias manifesto='./script5_manifesto_generator.sh'
# Then launch by typing just: manifesto
# Aliases live only for the current terminal session unless added to ~/.bashrc

# ── Inspirational quotes array (used at the end) ─────────────────────────────
QUOTES=(
    '"Given enough eyeballs, all bugs are shallow." — Eric S. Raymond'
    '"Free software is a matter of liberty, not price." — Richard Stallman'
    '"Talk is cheap. Show me the code." — Linus Torvalds'
    '"Python is an experiment in how much freedom programmers need." — Guido van Rossum'
    '"The best way to predict the future is to invent it." — Alan Kay'
)

# Pick a random quote using $RANDOM mod array length
RAND_QUOTE="${QUOTES[$((RANDOM % ${#QUOTES[@]}))]}"

# ── Header ────────────────────────────────────────────────────────────────────
clear
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║          Open Source Manifesto Generator                    ║"
echo "║          Powered by GNU Bash — GPL v3                       ║"
echo "║          VITyarthi | OSS Audit | Abdul Samad Khan           ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "  Answer five questions to generate your personal open-source"
echo "  philosophy statement. Your manifesto will be saved to a file."
echo ""
echo "──────────────────────────────────────────────────────────────"
echo ""

# ── Input helper: repeat until non-empty answer given ────────────────────────
prompt_required() {
    local PROMPT="$1"
    local VAR_NAME="$2"
    local INPUT=""
    while [ -z "$INPUT" ]; do
        read -p "  $PROMPT " INPUT
        if [ -z "$INPUT" ]; then
            echo "  [!] Answer cannot be empty. Please try again."
        fi
    done
    # Use eval to assign to the variable name passed in
    eval "$VAR_NAME=\"$INPUT\""
}

# ── Gather user input ─────────────────────────────────────────────────────────
echo "  Q1. What is your name?"
prompt_required "→" USER_FULL_NAME

echo ""
echo "  Q2. Name one open-source tool you use daily:"
prompt_required "→" FAVE_TOOL

echo ""
echo "  Q3. What does 'freedom in software' mean to you (in one sentence)?"
prompt_required "→" FREEDOM_MEANING

echo ""
echo "  Q4. What would you build and release freely if you had the skills?"
prompt_required "→" BUILD_DREAM

echo ""
echo "  Q5. Which open-source license do you prefer and why?"
echo "      (e.g. GPL because it keeps software free / MIT because it's simple)"
prompt_required "→" LICENSE_PREF

echo ""
echo "──────────────────────────────────────────────────────────────"
echo "  Generating your manifesto..."
sleep 1

# ── Output file ───────────────────────────────────────────────────────────────
DATE_STAMP=$(date '+%d %B %Y, %H:%M:%S')
SYS_USER=$(whoami)
OUTPUT_FILE="manifesto_${SYS_USER}.txt"

# ── Write manifesto using > (create/overwrite) and >> (append) ───────────────
echo "╔══════════════════════════════════════════════════════════════╗" > "$OUTPUT_FILE"
echo "║              MY OPEN SOURCE MANIFESTO                       ║" >> "$OUTPUT_FILE"
echo "╠══════════════════════════════════════════════════════════════╣" >> "$OUTPUT_FILE"
printf "║  %-20s : %-37s║\n" "Author"    "$USER_FULL_NAME" >> "$OUTPUT_FILE"
printf "║  %-20s : %-37s║\n" "System User" "$SYS_USER" >> "$OUTPUT_FILE"
printf "║  %-20s : %-37s║\n" "Generated"  "$DATE_STAMP" >> "$OUTPUT_FILE"
printf "║  %-20s : %-37s║\n" "Software"   "Python (PSF License)" >> "$OUTPUT_FILE"
echo "╚══════════════════════════════════════════════════════════════╝" >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"
echo "── MY PHILOSOPHY ────────────────────────────────────────────" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# String concatenation to build the manifesto body
echo "I am $USER_FULL_NAME, and every day I rely on $FAVE_TOOL —" >> "$OUTPUT_FILE"
echo "a tool that exists because someone chose to build in the open" >> "$OUTPUT_FILE"
echo "and give their work to the world without a price tag." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "To me, freedom in software means: $FREEDOM_MEANING" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "I believe that the most important software was not sold —" >> "$OUTPUT_FILE"
echo "it was shared. Guido van Rossum released Python in 1991" >> "$OUTPUT_FILE"
echo "not to get rich, but because he wanted a language people" >> "$OUTPUT_FILE"
echo "could use, study, and improve freely. Python now powers" >> "$OUTPUT_FILE"
echo "machine learning, scientific research, and web infrastructure" >> "$OUTPUT_FILE"
echo "for billions of people — because of one open decision." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "If I could build anything, I would create: $BUILD_DREAM" >> "$OUTPUT_FILE"
echo "and release it freely, because knowledge locked behind" >> "$OUTPUT_FILE"
echo "a paywall is knowledge withheld from the world." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "On licensing, I believe: $LICENSE_PREF" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "Open source is not just how software gets made." >> "$OUTPUT_FILE"
echo "It is a statement that the tools shaping our world" >> "$OUTPUT_FILE"
echo "should belong to everyone who lives in it." >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "── CLOSING THOUGHT ──────────────────────────────────────────" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "$RAND_QUOTE" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "─────────────────────────────────────────────────────────────" >> "$OUTPUT_FILE"
echo "Signed: $USER_FULL_NAME  |  $DATE_STAMP" >> "$OUTPUT_FILE"
echo "─────────────────────────────────────────────────────────────" >> "$OUTPUT_FILE"

# ── Display the finished manifesto ───────────────────────────────────────────
echo ""
echo "  [✔] Manifesto saved to: $OUTPUT_FILE"
echo ""
echo "══════════════════════════════════════════════════════════════"
cat "$OUTPUT_FILE"
echo "══════════════════════════════════════════════════════════════"
echo ""

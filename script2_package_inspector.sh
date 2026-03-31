#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: Abdul Samad Khan | Course: Open Source Software | VITyarthi
# Chosen Software: Python (PSF License)
# Concepts: if-then-elif-else, case statement, dpkg/rpm/command -v detection,
#           pipe with grep, function definitions, formatted output
# =============================================================================

# ── Helper function: print a section divider ─────────────────────────────────
print_divider() {
    echo "──────────────────────────────────────────────────────────────"
}

# ── Helper function: print a labelled key-value line ─────────────────────────
print_field() {
    printf "  %-18s : %s\n" "$1" "$2"
}

# ── Software to inspect ───────────────────────────────────────────────────────
PACKAGE="python3"          # primary name on Debian/Ubuntu
PACKAGE_ALT="python"       # fallback name (used on some systems / Git Bash)

echo ""
echo "══════════════════════════════════════════════════════════════"
echo "         FOSS Package Inspector — Python3 / Python"
echo "         VITyarthi | OSS Audit | Abdul Samad Khan"
echo "══════════════════════════════════════════════════════════════"
echo ""

# ── Step 1 — Detect package manager and query installation ───────────────────
INSTALLED=false
VERSION_STR=""
LICENSE_STR=""

if command -v dpkg &>/dev/null; then
    # Debian / Ubuntu / Kali / WSL
    echo "[INFO] dpkg detected — checking for python3..."
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        INSTALLED=true
        VERSION_STR=$(dpkg -s "$PACKAGE" 2>/dev/null | grep "^Version" | awk '{print $2}')
        LICENSE_STR=$(dpkg -s "$PACKAGE" 2>/dev/null | grep "^Homepage" | awk '{print $2}')
    fi

elif command -v rpm &>/dev/null; then
    # Fedora / RHEL / CentOS
    echo "[INFO] rpm detected — checking for python3..."
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        VERSION_STR=$(rpm -qi "$PACKAGE" 2>/dev/null | grep "^Version" | awk '{print $3}')
        LICENSE_STR=$(rpm -qi "$PACKAGE" 2>/dev/null | grep "^License" | awk '{print $3}')
    fi

else
    # Git Bash / macOS / any other system — binary detection only
    echo "[INFO] No dpkg/rpm found — using binary detection (Git Bash mode)..."
    if command -v python3 &>/dev/null; then
        INSTALLED=true
        VERSION_STR=$(python3 --version 2>&1 | awk '{print $2}')
        LICENSE_STR="PSF (confirmed via python3 --version)"
    elif command -v python &>/dev/null; then
        INSTALLED=true
        VERSION_STR=$(python --version 2>&1 | awk '{print $2}')
        LICENSE_STR="PSF (confirmed via python --version)"
    fi
fi

# ── Step 2 — Report installation status ──────────────────────────────────────
print_divider
if $INSTALLED; then
    echo "  [✔] Python is INSTALLED on this system."
    print_field "Version"   "${VERSION_STR:-unknown}"
    print_field "License"   "Python Software Foundation License (PSF)"
    print_field "Site"      "https://www.python.org"
    print_field "Source"    "https://github.com/python/cpython (open source)"
else
    echo "  [✘] Python was NOT found on this system."
    echo ""
    echo "  To install Python:"
    echo "    On Ubuntu/Debian : sudo apt install python3"
    echo "    On Fedora/RHEL   : sudo dnf install python3"
    echo "    On Windows       : https://www.python.org/downloads"
fi
print_divider

# ── Step 3 — Philosophy note using a case statement ──────────────────────────
echo ""
echo "  Open Source Philosophy Notes"
print_divider

# Determine which tool to spotlight based on what's available on the system
if command -v python3 &>/dev/null || command -v python &>/dev/null; then
    SPOTLIGHT="python"
elif command -v git &>/dev/null; then
    SPOTLIGHT="git"
elif command -v node &>/dev/null; then
    SPOTLIGHT="node"
elif command -v curl &>/dev/null; then
    SPOTLIGHT="curl"
else
    SPOTLIGHT="bash"
fi

case "$SPOTLIGHT" in
    python)
        echo "  Python:"
        echo "    Guido van Rossum released Python in 1991 as a language that"
        echo "    valued readability above all. The PSF License is deliberately"
        echo "    permissive — corporations like Google, NASA, and Instagram"
        echo "    ship Python in commercial products without any royalty."
        echo "    Its package ecosystem (PyPI) has over 500,000 open libraries."
        ;;
    git)
        echo "  Git:"
        echo "    Linus Torvalds wrote Git in April 2005 after BitKeeper revoked"
        echo "    free access from the Linux kernel team. In roughly ten days he"
        echo "    produced a distributed VCS under GPL v2 that now underpins"
        echo "    virtually every software project on Earth."
        ;;
    node)
        echo "  Node.js:"
        echo "    Released in 2009 under the MIT License, Node brought JavaScript"
        echo "    to the server — built on Chrome's V8 engine and licensed so"
        echo "    permissively that any company can embed it freely."
        ;;
    curl)
        echo "  curl:"
        echo "    Daniel Stenberg has maintained curl since 1998 under the MIT"
        echo "    License. It runs on over ten billion devices — smartphones,"
        echo "    cars, satellites — because its license imposes zero restrictions."
        ;;
    bash)
        echo "  GNU Bash:"
        echo "    The Bourne Again Shell, released under GPL v3, is the default"
        echo "    shell on most Linux systems and Git Bash on Windows. Richard"
        echo "    Stallman's GNU project created it to ensure every user has a"
        echo "    free, scriptable command interpreter — and it has shipped on"
        echo "    virtually every Unix-like OS for over 30 years."
        ;;
    *)
        echo "  Open Source:"
        echo "    Every major tool powering the internet was built openly and"
        echo "    shared freely. The FOSS model is not charity — it is an"
        echo "    engineering strategy that produces more reliable software."
        ;;
esac

# ── Step 4 — Compare PSF with other common licenses ──────────────────────────
echo ""
print_divider
echo "  License Comparison"
print_divider
printf "  %-20s %-15s %s\n" "Software" "License" "Can use in proprietary product?"
printf "  %-20s %-15s %s\n" "--------" "-------" "--------------------------------"
printf "  %-20s %-15s %s\n" "Python"   "PSF"     "Yes — no restrictions"
printf "  %-20s %-15s %s\n" "Linux"    "GPL v2"  "Yes — but must share kernel changes"
printf "  %-20s %-15s %s\n" "curl"     "MIT"     "Yes — no restrictions"
printf "  %-20s %-15s %s\n" "GCC"      "GPL v3"  "Yes — derivative must stay GPL"
printf "  %-20s %-15s %s\n" "OpenSSL"  "Apache 2.0" "Yes — attribution required"
print_divider
echo ""

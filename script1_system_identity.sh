#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author: Abdul Samad Khan | Course: Open Source Software | VITyarthi
# Chosen Software: Python (PSF License)
# Concepts: Variables, command substitution $(), echo, formatted output,
#           /etc/os-release parsing, conditional fallback detection
# =============================================================================

# ── Student & Software Meta ──────────────────────────────────────────────────
STUDENT_NAME="Abdul Samad Khan"
REG_NUMBER="[Your Registration Number]"
SOFTWARE="Python"
LICENSE="Python Software Foundation License (PSF) — Open Source, permissive"
OFFICIAL_SITE="https://www.python.org"

# ── System Information via command substitution ──────────────────────────────
# Try lsb_release first; fall back to /etc/os-release; final fallback for Git Bash
if command -v lsb_release &>/dev/null; then
    DISTRO=$(lsb_release -ds 2>/dev/null)
elif [ -f /etc/os-release ]; then
    DISTRO=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Git Bash on Windows (POSIX layer)"
fi

KERNEL=$(uname -r)
SHELL_VER=$(bash --version | head -1 | awk '{print $1, $2, $3, $4}')
ARCH=$(uname -m)
HOST=$(hostname)
CURRENT_USER=$(whoami)
HOME_DIR="$HOME"
DATETIME=$(date '+%A, %d %B %Y  |  %H:%M:%S %Z')

# Uptime — -p flag may not exist on all Git Bash builds; use a safe fallback
if uptime -p &>/dev/null 2>&1; then
    SYS_UPTIME=$(uptime -p)
else
    SYS_UPTIME=$(uptime | awk -F'( |,|:)+' '{print "up", $4, "hours", $5, "minutes"}')
fi

# Detect Python version if installed
if command -v python3 &>/dev/null; then
    PY_VERSION=$(python3 --version 2>&1)
elif command -v python &>/dev/null; then
    PY_VERSION=$(python --version 2>&1)
else
    PY_VERSION="Python not found in PATH"
fi

# ── Display formatted report ─────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           OPEN SOURCE AUDIT — SYSTEM IDENTITY               ║"
echo "║                  VITyarthi | OSS Course                     ║"
echo "╠══════════════════════════════════════════════════════════════╣"
printf "║  %-20s : %-37s║\n" "Student"    "$STUDENT_NAME"
printf "║  %-20s : %-37s║\n" "Reg. Number" "$REG_NUMBER"
printf "║  %-20s : %-37s║\n" "Software"   "$SOFTWARE"
echo "╠══════════════════════════════════════════════════════════════╣"
printf "║  %-20s : %-37s║\n" "Hostname"   "$HOST"
printf "║  %-20s : %-37s║\n" "OS / Distro" "$DISTRO"
printf "║  %-20s : %-37s║\n" "Kernel"     "$KERNEL"
printf "║  %-20s : %-37s║\n" "Architecture" "$ARCH"
printf "║  %-20s : %-37s║\n" "Shell"      "$SHELL_VER"
printf "║  %-20s : %-37s║\n" "User"       "$CURRENT_USER"
printf "║  %-20s : %-37s║\n" "Home"       "$HOME_DIR"
printf "║  %-20s : %-37s║\n" "Uptime"     "$SYS_UPTIME"
printf "║  %-20s : %-37s║\n" "Date/Time"  "$DATETIME"
echo "╠══════════════════════════════════════════════════════════════╣"
printf "║  %-20s : %-37s║\n" "Python Found"   "$PY_VERSION"
printf "║  %-20s : %-37s║\n" "PSF License"    "Free to use, modify & redistribute"
printf "║  %-20s : %-37s║\n" "Official Site"  "$OFFICIAL_SITE"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║  >> Python is free software. The PSF License lets anyone   ║"
echo "║     run, study, change and distribute Python — even inside  ║"
echo "║     commercial products — without paying a cent.            ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

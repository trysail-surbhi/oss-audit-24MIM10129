#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: Abdul Samad Khan | Course: Open Source Software | VITyarthi
# Chosen Software: Python (PSF License)
# Concepts: for loop with arrays, if-then-else, ls -ld, du -sh,
#           awk, cut, nested conditionals, permission risk scoring
# =============================================================================

# ── Directory list to audit ───────────────────────────────────────────────────
# Mix of system dirs (present on Linux) and Git Bash-accessible dirs
SYSTEM_DIRS=(
    "/etc"
    "/var/log"
    "/home"
    "/usr/bin"
    "/tmp"
    "/usr/lib"
)

# Python-related directories to audit specifically
PYTHON_DIRS=(
    "/usr/lib/python3"
    "/usr/local/lib"
    "$HOME/.local/lib"
    "$HOME/AppData/Local/Programs/Python"   # Windows typical path (Git Bash)
    "$HOME/.config"
)

# ── Helper: decode risk level from permission string ─────────────────────────
get_risk() {
    local PERM="$1"
    # World-writable (-------w-) = HIGH risk
    if echo "$PERM" | grep -q ".\{7\}w."; then
        echo "HIGH  ⚠"
    # World-readable but not writable = MEDIUM
    elif echo "$PERM" | grep -q ".\{7\}r.."; then
        echo "MED   ~"
    else
        echo "LOW   ✔"
    fi
}

# ── Header ────────────────────────────────────────────────────────────────────
echo ""
echo "══════════════════════════════════════════════════════════════"
echo "          Disk and Permission Auditor"
echo "          Focused: Python Installation Paths"
echo "          VITyarthi | OSS Audit | Abdul Samad Khan"
echo "══════════════════════════════════════════════════════════════"
echo ""

# ── Section 1: System directories ────────────────────────────────────────────
echo "  [SECTION 1] Core System Directories"
echo "──────────────────────────────────────────────────────────────"
printf "  %-28s %-12s %-8s %-6s %s\n" "Directory" "Permissions" "Owner" "Size" "Risk"
printf "  %-28s %-12s %-8s %-6s %s\n" "---------" "-----------" "-----" "----" "----"

for DIR in "${SYSTEM_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permission string (field 1) and owner (field 3) from ls
        PERM=$(ls -ld "$DIR" 2>/dev/null | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" 2>/dev/null | awk '{print $3}')
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        RISK=$(get_risk "$PERM")
        printf "  %-28s %-12s %-8s %-6s %s\n" "$DIR" "$PERM" "$OWNER" "${SIZE:---}" "$RISK"
    else
        printf "  %-28s %s\n" "$DIR" "[does not exist on this system]"
    fi
done

echo ""

# ── Section 2: Python-specific directories ───────────────────────────────────
echo "  [SECTION 2] Python-Related Directories"
echo "──────────────────────────────────────────────────────────────"
printf "  %-38s %-12s %-6s %s\n" "Path" "Permissions" "Size" "Status"
printf "  %-38s %-12s %-6s %s\n" "----" "-----------" "----" "------"

for PYDIR in "${PYTHON_DIRS[@]}"; do
    if [ -d "$PYDIR" ]; then
        PERM=$(ls -ld "$PYDIR" 2>/dev/null | awk '{print $1}')
        SIZE=$(du -sh "$PYDIR" 2>/dev/null | cut -f1)
        printf "  %-38s %-12s %-6s %s\n" "$PYDIR" "$PERM" "${SIZE:---}" "[FOUND]"
    else
        printf "  %-38s %-12s %-6s %s\n" "$PYDIR" "---" "---" "[not found]"
    fi
done

echo ""

# ── Section 3: Python binary check ───────────────────────────────────────────
echo "  [SECTION 3] Python Binary Locations"
echo "──────────────────────────────────────────────────────────────"

# Loop through possible Python executable names
for PY_CMD in python3 python python3.11 python3.10 python3.9; do
    if command -v "$PY_CMD" &>/dev/null; then
        PY_PATH=$(command -v "$PY_CMD")
        PY_PERM=$(ls -l "$PY_PATH" 2>/dev/null | awk '{print $1}')
        PY_SIZE=$(du -sh "$PY_PATH" 2>/dev/null | cut -f1)
        echo "  [✔] $PY_CMD found at : $PY_PATH"
        echo "      Permissions        : $PY_PERM"
        echo "      Binary size        : ${PY_SIZE:---}"
        echo ""
    fi
done

# If none found at all
if ! command -v python3 &>/dev/null && ! command -v python &>/dev/null; then
    echo "  [✘] No Python binary found in PATH."
    echo "      Download Python from: https://www.python.org/downloads"
fi

# ── Section 4: /tmp writability check ────────────────────────────────────────
echo "  [SECTION 4] Writability Check — /tmp"
echo "──────────────────────────────────────────────────────────────"

if [ -d /tmp ]; then
    TEST_FILE="/tmp/oss_audit_write_test_$$"
    if touch "$TEST_FILE" 2>/dev/null; then
        echo "  [✔] /tmp is writable by current user ($CURRENT_USER)."
        rm -f "$TEST_FILE"
    else
        echo "  [✘] /tmp is NOT writable. This is unusual — check permissions."
    fi
else
    echo "  [--] /tmp directory not found on this system."
fi

# ── Footer note ───────────────────────────────────────────────────────────────
echo ""
echo "──────────────────────────────────────────────────────────────"
echo "  WHY THIS MATTERS FOR PYTHON:"
echo "  Python installs packages to user or system directories."
echo "  If site-packages/ is world-writable, malicious code could"
echo "  be injected into every script that imports a module."
echo "  Always verify pip installs go to your own user directory:"
echo "    pip install --user <package>"
echo "──────────────────────────────────────────────────────────────"
echo ""

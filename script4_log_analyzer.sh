#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author: Abdul Samad Khan | Course: Open Source Software | VITyarthi
# Chosen Software: Python (PSF License)
# Concepts: while IFS= read -r loop, if-then, counter variables $((N+1)),
#           $1 $2 positional arguments, grep -i, tail, wc -l,
#           arrays for multi-keyword tracking, input validation
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh test.log error
# =============================================================================

# ── Positional arguments ──────────────────────────────────────────────────────
LOGFILE="$1"                  # Arg 1: path to the log file
KEYWORD="${2:-error}"         # Arg 2: keyword to search (default: error)

# ── Counters ──────────────────────────────────────────────────────────────────
MATCH_COUNT=0        # lines containing the keyword
TOTAL_LINES=0        # total lines read
WARN_COUNT=0         # lines containing "warning" (bonus insight)
INFO_COUNT=0         # lines containing "info"
BLANK_COUNT=0        # blank lines skipped

# ── Header ────────────────────────────────────────────────────────────────────
echo ""
echo "══════════════════════════════════════════════════════════════"
echo "              Log File Analyzer"
echo "              VITyarthi | OSS Audit | Abdul Samad Khan"
echo "══════════════════════════════════════════════════════════════"
echo ""

# ── Input validation ──────────────────────────────────────────────────────────
# Check: was a logfile argument given at all?
if [ -z "$LOGFILE" ]; then
    echo "  [!!] ERROR: No log file specified."
    echo ""
    echo "  Usage   : ./script4_log_analyzer.sh <logfile> [keyword]"
    echo "  Example : ./script4_log_analyzer.sh test.log error"
    echo ""
    echo "  To create a test log and run this script:"
    echo '    printf "INFO: server started\nERROR: connection refused\nWARNING: high memory usage\nERROR: disk I/O failure\nINFO: retrying...\n" > test.log'
    echo "    ./script4_log_analyzer.sh test.log error"
    echo ""
    exit 1
fi

# Check: does the file exist?
if [ ! -f "$LOGFILE" ]; then
    echo "  [!!] ERROR: '$LOGFILE' not found."
    echo ""
    RETRY_COUNT=0
    # Retry loop — do-while style: runs at least once, prompts user to try again
    while [ $RETRY_COUNT -lt 3 ]; do
        RETRY_COUNT=$((RETRY_COUNT + 1))
        echo "  Attempt $RETRY_COUNT / 3 — checking again in 1 second..."
        sleep 1
        if [ -f "$LOGFILE" ]; then
            echo "  [✔] File appeared. Continuing..."
            break
        fi
        if [ $RETRY_COUNT -eq 3 ]; then
            echo ""
            echo "  File still not found after 3 attempts. Exiting."
            echo ""
            echo "  Tip: Generate a test log with:"
            echo '    printf "INFO: boot ok\nERROR: auth failed\nWARNING: disk 90%%\nERROR: segfault\n" > test.log'
            echo ""
            exit 1
        fi
    done
fi

# Check: is the file empty?
if [ ! -s "$LOGFILE" ]; then
    echo "  [!!] WARNING: '$LOGFILE' is empty — nothing to analyse."
    exit 1
fi

echo "  Log File  : $LOGFILE"
echo "  Keyword   : '$KEYWORD'  (case-insensitive)"
echo "  Scanning..."
echo ""

# ── Main while-read loop: read line by line ───────────────────────────────────
while IFS= read -r LINE; do
    TOTAL_LINES=$((TOTAL_LINES + 1))

    # Skip blank lines (but count them)
    if [ -z "$LINE" ]; then
        BLANK_COUNT=$((BLANK_COUNT + 1))
        continue
    fi

    # Check for the primary keyword (case-insensitive)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        MATCH_COUNT=$((MATCH_COUNT + 1))
    fi

    # Bonus counters — useful log-level breakdown
    if echo "$LINE" | grep -iq "warning\|warn"; then
        WARN_COUNT=$((WARN_COUNT + 1))
    fi
    if echo "$LINE" | grep -iq "^info\|: info\| info:"; then
        INFO_COUNT=$((INFO_COUNT + 1))
    fi

done < "$LOGFILE"    # feed file into while loop via stdin redirection

# ── Results summary ───────────────────────────────────────────────────────────
echo "──────────────────────────────────────────────────────────────"
echo "  ANALYSIS SUMMARY"
echo "──────────────────────────────────────────────────────────────"
printf "  %-30s : %d\n" "Total lines in file"        "$TOTAL_LINES"
printf "  %-30s : %d\n" "Blank lines (skipped)"       "$BLANK_COUNT"
printf "  %-30s : %d\n" "Lines with '$KEYWORD'"       "$MATCH_COUNT"
printf "  %-30s : %d\n" "Lines with WARNING/WARN"     "$WARN_COUNT"
printf "  %-30s : %d\n" "Lines with INFO"             "$INFO_COUNT"
echo "──────────────────────────────────────────────────────────────"

# ── Show matching lines ───────────────────────────────────────────────────────
if [ $MATCH_COUNT -gt 0 ]; then
    echo ""
    echo "  Last 5 lines matching '$KEYWORD':"
    echo "  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·"
    grep -in "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r MATCH_LINE; do
        echo "  → $MATCH_LINE"
    done
    echo ""

    # Severity estimate: if > 10% of lines are errors that's worth flagging
    PERCENT=$(( (MATCH_COUNT * 100) / TOTAL_LINES ))
    if [ $PERCENT -ge 30 ]; then
        echo "  [⚠] HIGH error rate: $PERCENT% of log lines matched '$KEYWORD'."
        echo "      Recommend reviewing recent changes to the system."
    elif [ $PERCENT -ge 10 ]; then
        echo "  [~] MODERATE error rate: $PERCENT% of log lines matched '$KEYWORD'."
    else
        echo "  [✔] LOW error rate: $PERCENT% of log lines matched '$KEYWORD'."
    fi
else
    echo ""
    echo "  [✔] No lines matched '$KEYWORD' — log looks clean."
fi

# ── Python connection note ────────────────────────────────────────────────────
echo ""
echo "──────────────────────────────────────────────────────────────"
echo "  CONNECTION TO PYTHON:"
echo "  Python writes structured logs via its built-in 'logging'"
echo "  module using levels: DEBUG < INFO < WARNING < ERROR < CRITICAL"
echo "  This script mimics what Python's logging.handlers module"
echo "  does — scan files for severity keywords and triage issues."
echo "  The same grep+count logic is the basis of tools like Loguru"
echo "  and Sentry — both open-source Python libraries."
echo "──────────────────────────────────────────────────────────────"
echo ""

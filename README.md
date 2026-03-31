# 🐍 The Open Source Audit , Python

---

## 👤 Student Details

| Field | Details |
|---|---|
| **Student Name** | Surbhi Agnihotri |
| **Registration Number** | 24MIM10129 |

---

## 🖥️ Chosen Software

**Software:** Python  
**License:** Python Software Foundation License (PSF)  
**Category:** General-purpose Programming Language  
**Official Site:** https://www.python.org  
**Source Code:** https://github.com/python/cpython  

Python was first released by Guido van Rossum on 20 February 1991.The PSF License is one of the most permissive open-source licences in existence: it imposes no restrictions on commercial use, redistribution, or modification. This is why Python ships inside products made by Google, NASA, Instagram, Netflix, and Dropbox , all without paying a royalty. Today Python is consistently ranked the world's most popular programming language, powering machine learning, web development, data science, automation, and systems scripting.

---

## 💻 Environment

These scripts were developed and tested on **Windows 11 using Git Bash** , the Unix-compatible shell bundled with Git for Windows. Git Bash provides a POSIX-compliant Bash environment on Windows, giving access to standard Unix tools (`grep`, `awk`, `du`, `ls`, `uname`, `date`, etc.) without needing a full Linux installation.

**Shell:** GNU Bash (bundled with Git for Windows)  
**Tested on:** Windows 11 + Git Bash 2.x  
**Also compatible with:** Ubuntu, Debian, Kali Linux, WSL2

---

## 📁 Repository Structure

```
oss-audit-24MIM10129/
│
├── script1_system_identity.sh      # System Identity Report
├── script2_package_inspector.sh    # FOSS Package Inspector
├── script3_disk_auditor.sh         # Disk and Permission Auditor
├── script4_log_analyzer.sh         # Log File Analyzer
├── script5_manifesto_generator.sh  # Open Source Manifesto Generator
└── README.md                       # This file
```

---

## 📜 Script Descriptions

### Script 1 , System Identity Report

Displays a fully formatted welcome screen inside a Unicode box border. Reports the OS/distro (with a multi-level fallback: `lsb_release` → `/etc/os-release` → Git Bash label), kernel version, Bash version, CPU architecture, hostname, logged-in user, home directory, system uptime (with a safe fallback for Git Bash), and the current date and time. Also detects whether Python is installed and prints its version alongside the PSF licence details.

**Concepts used:** Variables, `echo`, command substitution `$()`, `printf` for column alignment, conditional `if-elif-else` fallback detection, `uname`, `whoami`, `hostname`, `date`, `uptime`, `/etc/os-release`, `command -v`

---

### Script 2 , FOSS Package Inspector

Detects the system's package manager in order (`dpkg` → `rpm` → binary fallback) and queries whether Python 3 is installed, printing version and licence information. Uses a `case` statement to dynamically detect which FOSS tool is available on the current machine and print a tailored philosophy note about it. Ends with a formatted licence comparison table showing PSF vs GPL vs MIT vs Apache 2.0.

**Concepts used:** `if-then-elif-else`, `case` statement, `dpkg -s`, `rpm -qi`, `command -v`, pipe with `grep`, `printf` for table formatting, helper functions

---

### Script 3 , Disk and Permission Auditor

Loops through core system directories and Python-specific install paths, reporting permissions, owner, and size. Includes a helper function `get_risk()` that reads the permission string and returns a LOW / MEDIUM / HIGH risk label, adding a layer of automated security analysis. Also loops over multiple Python binary names (`python3`, `python`, `python3.11`, etc.) to find whichever version is installed. Ends with a writability test on `/tmp`.

**Concepts used:** `for` loop with arrays, `if-then-else`, nested function definition, `ls -ld`, `du -sh`, `awk '{print $1, $3}'`, `cut -f1`, `touch` for writability test, `command -v`, risk-scoring logic

---

### Script 4 , Log File Analyzer

Reads a log file line by line, counting matches for a keyword (default: `error`) as well as secondary counters for `warning` and `info` lines. Implements a retry loop that checks for the file up to three times with a 1-second pause between attempts. After scanning, computes the error percentage and classifies severity as LOW / MODERATE / HIGH. Shows the last 5 matching lines with line numbers.

**Concepts used:** `while IFS= read -r`, `if-then`, counter variables `$((N + 1))`, `$1`/`$2` positional arguments, `grep -in`, `tail -5`, `wc -l`, retry loop with `sleep`, percentage arithmetic `$(())`, input validation

**Usage:**
```bash
# Create a test log on Git Bash or Linux:
printf "INFO: server started\nERROR: connection refused\nWARNING: high memory\nERROR: disk I/O failure\nINFO: retrying\n" > test.log

# Run the analyzer:
./script4_log_analyzer.sh test.log error

# On Linux with a real system log:
./script4_log_analyzer.sh /var/log/syslog error
```

---

### Script 5 , Open Source Manifesto Generator

Prompts the user for five answers using a reusable `prompt_required()` validation helper that loops until a non-empty answer is provided. Assembles all answers into a personalised manifesto using string concatenation and writes it to `manifesto_<username>.txt` using `>` (create) and `>>` (append). Selects a random closing quote from a quotes array using `$RANDOM`. Demonstrates the alias concept in a comment block. Displays the finished manifesto with `cat`.

**Concepts used:** `read -p`, `while` validation loop, helper function with `eval`, string concatenation, `>` and `>>` file redirection, arrays with `$RANDOM` indexing, `date`, `whoami`, `cat`, `clear`, `sleep`, alias concept (demonstrated in comment)

---

## ⚙️ Dependencies

### On Git Bash (Windows)

Git Bash ships with everything these scripts need. Just install Git for Windows:

- Download: https://git-scm.com/download/win
- During installation, select **"Use Git Bash as default shell"**
- Included tools: `grep`, `awk`, `cut`, `ls`, `du`, `date`, `uname`, `printf`, `sleep`

### On Linux (Ubuntu / Debian)

```bash
sudo apt update
sudo apt install git bash coreutils grep gawk lsb-release
```

---

## 🚀 How to Run

### On Git Bash (Windows)

**Step 1 , Install Git for Windows**  
Download and install from https://git-scm.com/download/win.

**Step 2 , Clone or download this repository**  
```bash
git clone https://github.com/YOUR_USERNAME/oss-audit-ROLLNUMBER.git
cd oss-audit-ROLLNUMBER
```

**Step 3 , Make scripts executable**  
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

Or all at once:
```bash
chmod +x script*.sh
```

**Step 4 , Run each script**  
```bash
# Script 1: System Identity
./script1_system_identity.sh

# Script 2: Package Inspector
./script2_package_inspector.sh

# Script 3: Disk Auditor
./script3_disk_auditor.sh

# Script 4: Log Analyzer , create a test log first
printf "INFO: boot ok\nERROR: auth failed\nWARNING: disk 90%%\nERROR: segfault\nINFO: recovered\n" > test.log
./script4_log_analyzer.sh test.log error

# Script 5: Manifesto Generator (interactive , it will ask you 5 questions)
./script5_manifesto_generator.sh
```


---

## 🧠 Shell Concepts Covered

| Concept | Script(s) |
|---|---|
| Variables & command substitution `$()` | 1, 2, 3, 4, 5 |
| `if-then-elif-else` with multi-level fallback | 1, 2, 3, 4 |
| `case` statement with dynamic spotlight selection | 2 |
| Helper functions with `eval` parameter passing | 3, 5 |
| `for` loop with arrays | 3 |
| `while IFS= read -r` line-by-line file loop | 4 |
| Retry loop with `sleep` (do-while style) | 4 |
| `while` validation loop for required input | 5 |
| Counter variables & arithmetic `$(())` | 4 |
| Percentage & severity classification | 4 |
| Positional arguments `$1`, `$2` | 4 |
| `read -p` for interactive user input | 5 |
| Arrays with `$RANDOM` indexing | 5 |
| File writing with `>` (create) and `>>` (append) | 5 |
| `printf` for column-aligned table output | 1, 2, 3 |
| `grep`, `awk`, `cut`, `tail`, `wc`, `du`, `ls` | 2, 3, 4 |
| `command -v` for portable binary detection | 1, 2, 3 |
| Alias concept (demonstrated in comment) | 5 |
| Risk-scoring function from permission string | 3 |

---

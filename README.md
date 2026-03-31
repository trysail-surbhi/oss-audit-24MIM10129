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
**Script 1:** System Identity Report
Displays a formatted welcome screen with system details including OS/Distro, kernel version, CPU architecture, and uptime. It performs a "check" to detect if Python is installed and prints its PSF license info.

**Concepts:** Variables, printf alignment, if-elif-else fallbacks, and command substitution $().

**Script 2:** FOSS Package Inspector
Queries the system package manager (dpkg/rpm) to verify Python 3. It uses a case statement to provide a tailored FOSS philosophy note and generates a formatted comparison table of common licenses (PSF, GPL, MIT, Apache).

**Concepts:** case statements, grep piping, helper functions, and package management commands.

**Script 3:** Disk and Permission Auditor
Loops through system and Python directories to report permissions, ownership, and folder size. It features a get_risk() function that assigns a LOW/HIGH security risk label based on folder access levels.

**Concepts:** for loops, arrays, awk for text processing, du -sh for disk usage, and risk-scoring logic.

**Script 4:** Log File Analyzer
Scans log files line-by-line to count "error," "warning," and "info" matches. It includes a 3-second retry loop if a file is missing, calculates the error percentage, and classifies the overall system severity.

**Concepts:** while IFS= read loops, positional arguments ($1, $2), integer arithmetic, and sleep for retry logic.

**Script 5:** Open Source Manifesto Generator
An interactive script that prompts the user for personal views on FOSS. It validates inputs, picks a random open-source quote using $RANDOM, and saves the final result into a new .txt file.

Concepts: read -p input, > and >> file redirection, array indexing, and string concatenation.

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

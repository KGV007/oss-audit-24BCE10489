# The Open Source Audit — Shell Script Project

- **Course:** Open Source Software
- **Student Name:** Kevin George Varghese 
- **Roll Number:** 24BCE10489  
- **Chosen Software:** Apache HTTP Server (`httpd`)

---

## Table of Contents

- [Project Overview](#project-overview)
- [Chosen Software](#chosen-software)
- [Repository Structure](#repository-structure)
- [Dependencies & System Requirements](#dependencies--system-requirements)
- [Setup Instructions](#setup-instructions)
- [Script Descriptions & How to Run](#script-descriptions--how-to-run)
  - [Script 1 — System Identity Report](#script-1--system-identity-report)
  - [Script 2 — FOSS Package Inspector](#script-2--foss-package-inspector)
  - [Script 3 — Disk and Permission Auditor](#script-3--disk-and-permission-auditor)
  - [Script 4 — Log File Analyzer](#script-4--log-file-analyzer)
  - [Script 5 — Open Source Manifesto Generator](#script-5--open-source-manifesto-generator)
- [Shell Concepts Covered](#shell-concepts-covered)
- [Sample Output Screenshots](#sample-output-screenshots)
- [Troubleshooting](#troubleshooting)

---

## Project Overview

This project is part of the **Open Source Software Capstone Audit** at VIT. It consists of five Bash shell scripts that explore Linux system administration, FOSS (Free and Open Source Software) package management, file permissions, log analysis, and open source philosophy — all through practical scripting.

Each script is fully commented, demonstrating core Bash concepts including variables, loops, conditionals, command substitution, user input, and file I/O.

---

## Chosen Software

| Field         | Details                          |
|---------------|----------------------------------|
| Software Name | Apache HTTP Server               |
| Package Name  | `httpd` (RPM) / `apache2` (DEB)  |
| License       | Apache License 2.0               |
| Purpose       | Open-source web server           |
| Website       | https://httpd.apache.org         |

Apache HTTP Server was chosen because it is one of the most historically significant open source projects in existence, powering the early growth of the World Wide Web since 1995 entirely through community-driven development.

---

## Repository Structure

```
open-source-audit/
│
├── system_identity.sh       # System welcome screen & info report
├── foss_inspector.sh        # FOSS package checker & philosophy notes
├── disk_permission_auditor.sh  # Directory permissions & disk usage
├── log_analyzer.sh         # Log file keyword counter & analyzer
├── manifesto_generator.sh  # Interactive open source manifesto creator
│
└── README.md                        # This file
```

---

## Dependencies & System Requirements

### Operating System
- Any modern **Linux distribution** (tested on Fedora, Ubuntu, Debian, CentOS)
- Scripts must be run on a **real Linux system** (not Windows CMD/PowerShell)
- WSL (Windows Subsystem for Linux) is acceptable

### Shell
- **Bash** version 4.0 or higher
- Check your version: `bash --version`

### Required Tools (usually pre-installed on Linux)

| Tool       | Used In         | Purpose                              | Install (if missing)              |
|------------|-----------------|--------------------------------------|-----------------------------------|
| `bash`     | All scripts     | Script interpreter                   | Pre-installed                     |
| `uname`    | Script 1        | Get kernel version                   | Pre-installed (`coreutils`)       |
| `whoami`   | Script 1, 5     | Get current username                 | Pre-installed (`coreutils`)       |
| `uptime`   | Script 1        | System uptime                        | Pre-installed (`procps`)          |
| `date`     | Script 1, 5     | Current date and time                | Pre-installed (`coreutils`)       |
| `rpm`      | Script 2        | Package info (RPM-based systems)     | Pre-installed on Fedora/RHEL      |
| `dpkg`     | Script 2        | Package info (DEB-based systems)     | Pre-installed on Ubuntu/Debian    |
| `ls`       | Script 3        | Directory permissions                | Pre-installed (`coreutils`)       |
| `du`       | Script 3        | Disk usage                           | Pre-installed (`coreutils`)       |
| `awk`      | Script 3        | Field extraction from output         | Pre-installed (`gawk`)            |
| `grep`     | Script 2, 4     | Pattern matching in text             | Pre-installed (`grep`)            |
| `tail`     | Script 4        | Get last N lines of a file           | Pre-installed (`coreutils`)       |
| `cat`      | Script 5        | Display file contents                | Pre-installed (`coreutils`)       |

> **Note:** No third-party packages need to be installed. All tools ship with a standard Linux system.

---


### Script 1 — System Identity Report

**File:** `system_identity.sh`  
**Units Covered:** Unit 1 & 2

#### Description
Displays a formatted welcome screen that introduces the Linux system. It reports the Linux distribution name, kernel version, currently logged-in user, their home directory, system uptime, current date and time, and the open-source license that covers the OS. The output is styled to resemble a system info panel.

#### Concepts Demonstrated
- **Variables** — storing system info in named variables
- **Command substitution `$()`** — capturing output of commands like `uname`, `whoami`, `uptime`, `date`
- **`echo`** — formatted terminal output
- **Conditional file check** — reading `/etc/os-release` to detect the distro

#### How to Run

```bash
bash system_identity.sh
```

---

### Script 2 — FOSS Package Inspector

**File:** `foss_inspector.sh`  
**Units Covered:** Unit 2

#### Description
Checks whether your chosen FOSS package is installed on the system. It auto-detects the package manager (RPM-based or DEB-based) and queries the package database for version, license, and summary information. A `case` statement then prints a tailored open source philosophy note based on which package is being inspected.

#### Concepts Demonstrated
- **`if-then-else`** — checking if a package is installed
- **`case` statement** — printing different philosophy notes per package
- **`rpm -qi` / `dpkg -l`** — querying package information
- **Pipe with `grep -E`** — filtering specific fields from package output
- **`command -v`** — detecting which package manager is available

#### How to Run

```bash
bash foss_inspector.sh
```

> Before running, set the `PACKAGE` variable inside the script to your chosen package name (e.g. `httpd`, `mysql`, `firefox`, `vlc`, `git`).

---

### Script 3 — Disk and Permission Auditor

**File:** `disk_permission_auditor.sh`  
**Units Covered:** Unit 2

#### Description
Iterates through a predefined list of important Linux system directories using a `for` loop and reports each directory's permissions, owner, group, and disk usage. It then performs a dedicated check on your chosen software's configuration directory, reporting its permissions and flagging any world-writable security risks.

#### Concepts Demonstrated
- **`for` loop** — iterating over an array of directories
- **`ls -ld`** — getting directory permissions and ownership
- **`awk`** — extracting specific fields (permissions, owner, group)
- **`du -sh`** — human-readable disk usage
- **`cut`** — trimming output fields
- **Directory existence check `[ -d ]`** — validating paths before access

#### How to Run

```bash
bash disk_permission_auditor.sh
```

> Set `SOFTWARE_CONFIG_DIR` in the script to your software's config path (e.g. `/etc/httpd` for Apache, `/etc/mysql` for MySQL).
---
### Script 4 — Log File Analyzer

**File:** `log_analyzer.sh`  
**Units Covered:** Unit 2 & 5

#### Description
Accepts a log file path and an optional search keyword as command-line arguments. It reads the log file line by line using a `while read` loop, counting every line that contains the keyword (case-insensitive). If the log file is empty, a do-while style retry loop waits and retries up to 3 times. After analysis, it prints a summary count and displays the last 5 matching lines using `grep` and `tail`.

#### Concepts Demonstrated
- **`while read` loop** — reading a file line by line safely
- **`if-then` inside loop** — checking each line for keyword match
- **Counter variable** — incrementing `COUNT` with `$(())`
- **Command-line arguments `$1`, `$2`** — accepting input from the terminal
- **do-while style retry** — simulated using `while true` with a `break`
- **`grep | tail`** — extracting and limiting matched lines

#### How to Run

```bash
# Basic usage (default keyword: 'error')
bash log_analyzer.sh /var/log/syslog

# Custom keyword
bash log_analyzer.sh /var/log/syslog WARNING

# On RPM-based systems (Fedora/CentOS), try:
bash log_analyzer.sh /var/log/messages error
```

> The log file `/var/log/syslog` exists on Ubuntu/Debian systems.  
> On Fedora/RHEL systems, use `/var/log/messages`.  
> You may need `sudo` to read some log files.

---

### Script 5 — Open Source Manifesto Generator

**File:** `manifesto_generator.sh`  
**Units Covered:** Unit 5

#### Description
An interactive script that asks the user three questions using `read -p`, then composes a personalised open source philosophy paragraph using their answers through string concatenation. The final manifesto is saved to a `.txt` file named after the current user (e.g. `manifesto_jane.txt`) and displayed in the terminal. The alias concept is demonstrated via an in-script comment.

#### Concepts Demonstrated
- **`read`** — capturing interactive user input with `-p` prompt
- **String concatenation** — combining variables and literal text into a paragraph
- **Writing to a file** — using `>` (create/overwrite) and `>>` (append)
- **`date` command** — embedding the current date in output
- **`cat`** — displaying the saved file in the terminal
- **Aliases** — concept explained via comment (`alias mkmanifesto='bash script5...'`)

#### How to Run

```bash
bash manifesto_generator.sh
```

The script will interactively prompt you. Type your answers and press Enter after each one.

---

## Troubleshooting

**`Permission denied` when running a script**
```bash
chmod +x scriptname.sh
```

**`rpm: command not found` on Ubuntu/Debian**
> Script 2 automatically falls back to `dpkg`. No action needed.

**`/var/log/syslog` not found on Fedora**
```bash
bash log_analyzer.sh /var/log/messages error
```

**`/etc/httpd` not found**
> Apache may not be installed. Install it or change `SOFTWARE_CONFIG_DIR` to a directory that exists on your system (e.g. `/etc/nginx`, `/etc/mysql`).

**Script shows `Unknown Linux Distribution`**
> Your system may lack `/etc/os-release`. Run `cat /etc/issue` manually to find your distro name.

---

## License

This project is submitted as academic coursework for the Open Source Software course at VIT Bhopal University.
Scripts are written for educational purposes.
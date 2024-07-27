# WHM Suite Installer

## Overview

`whm-suite-installer` is a comprehensive bash script designed to automate the installation of a suite of essential tools and software for WHM (WebHost Manager) on AlmaLinux. This script simplifies the setup process by installing and configuring WHM/cPanel, LiteSpeed, CloudLinux, Imunify360, JetBackup, and WHMReseller.

## Features

- **WHM/cPanel**: Installs the latest version of WHM/cPanel.
- **LiteSpeed**: Installs LiteSpeed Web Server, disables `mod_ruid2`, and displays admin login information.
- **CloudLinux**: Prompts for and uses an activation key to install CloudLinux.
- **Imunify360**: Installs Imunify360 for enhanced server security.
- **JetBackup**: Installs JetBackup5 for reliable server backups.
- **WHMReseller**: Installs WHMReseller for managing reseller accounts.

## Prerequisites

- AlmaLinux server
- Root access
- Internet connection

## Usage

To download and run the script directly, use the following command:

```sh
wget -O install.sh https://raw.githubusercontent.com/Sajibekanti/whm-suite-installer/main/install.sh && bash install.sh

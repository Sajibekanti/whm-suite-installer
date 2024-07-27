#!/bin/bash

# Script Name: WHM Suite
# Author : Sajibe Kanti
# Description: Installs WHM, Imunify360, LiteSpeed, CloudLinux, JetBackup, and WHMReseller on AlmaLinux.

# Function to print the banner
print_banner() {
    echo " +-++-++-+ +-++-++-++-++-+                "
    echo " |W||H||M| |S||u||i||t||e|                "
    echo " +-++-+++-++-++-++-++-++-+ +-++-++-++-++-+"
    echo " |b||y| |S||a||j||i||b||e| |K||a||n||t||i|"
    echo " +-++-+ +-++-++-++-++-++-+ +-++-++-++-++-+"
}

# Function to show OS Kernel Version & OS Name & Update OS
update_os() {
    echo "Step 1: Showing OS Kernel Version & OS Name & Updating OS..."
    uname -r
    cat /etc/os-release
    yum update -y
}

# Function to customize the version of MySQL or MariaDB
customize_mysql_version() {
    echo "Step 2: Customizing the version of MySQL or MariaDB..."
    mkdir -p /root/cpanel_profile
    echo "mysql-version=10.11" > /root/cpanel_profile/cpanel.config
}

# Function to install WHM / cPanel
install_whm() {
    echo "Step 3: Installing WHM / cPanel..."
    cd /home && curl -o latest -L https://securedownloads.cpanel.net/latest && sh latest
}

# Function to install LiteSpeed
install_litespeed() {
    echo "Step 4: Installing LiteSpeed..."
    
    # Disable mod_ruid2 in EasyApache4
    echo "Disabling mod_ruid2 in EasyApache4..."
    /usr/local/bin/ea_install_profile --install=ea4
    /usr/local/cpanel/scripts/disable_easyapache4_mod --disable=mod_ruid2

    # Install LiteSpeed
    echo "Running LiteSpeed installation..."
    bash <(curl -s https://get.litespeed.sh) <<EOF
y
2
1000
admin
root@localhost
1
0
0
EOF
    
    # Grab LiteSpeed Admin login info
    LITESPEED_ADMIN=$(cat /usr/local/lsws/adminpasswd | grep 'admin' | awk '{print $2}')
    echo "LiteSpeed Admin login info: admin / $LITESPEED_ADMIN"
}

# Function to install CloudLinux
install_cloudlinux() {
    echo "Step 5: Installing CloudLinux..."
    echo -n "Enter your CloudLinux activation key: "
    read ACTIVATION_KEY
    yum install wget -y
    wget https://repo.cloudlinux.com/cloudlinux/sources/cln/cldeploy
    bash cldeploy -k $ACTIVATION_KEY
}

# Function to install Imunify360
install_imunify360() {
    echo "Step 6: Installing Imunify360..."
    wget https://repo.imunify360.cloudlinux.com/defence360/i360deploy.sh
    bash i360deploy.sh
}

# Function to install JetBackup5
install_jetbackup5() {
    echo "Step 7: Installing JetBackup5..."
    bash <(curl -LSs http://repo.jetlicense.com/static/install)
    jetapps --install jetbackup5-cpanel stable
}

# Function to install WHMReseller
install_whmreseller() {
    echo "Step 8: Installing WHMReseller..."
    cd /usr/local/cpanel/whostmgr/docroot/cgi
    wget https://deasoft.com/whmreseller/install.cpp
    g++ install.cpp -o install
    chmod 700 install
    ./install
    rm install
    rm install.cpp
}

# Main installation steps
main() {
    print_banner
    update_os
    customize_mysql_version
    install_whm
    install_litespeed
    install_cloudlinux
    install_imunify360
    install_jetbackup5
    install_whmreseller

    echo "All installations completed successfully!"
    echo "Now you can log in to your WHM."
    echo "LiteSpeed Admin Login Info: admin / $LITESPEED_ADMIN"
}

main

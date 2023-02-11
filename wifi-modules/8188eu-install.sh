#!/bin/bash
#  ∆  Realtek 8188eu driver installer for ARM71 x32
# ∆ ∆ d3vilh@github 2023. For vpntv project.

arch=$(uname -m)
kernel=$(uname -r) #kernel="5.15.84+" 
if [ -z "$kernel" ]; then
    echo "Error: Could not determine kernel version"
    exit 1
fi
module_bin="./wifi-modules/"$arch"/"$kernel"/8188eu.ko"
module_dir="/lib/modules/$kernel/kernel/drivers/net/wireless"

# install module
echo "Installing $module_bin for Linux $kernel to $module_dir"
sudo install -p -m 644 $module_bin $module_dir

# update module dependencies
echo "Updating module dependencies"
sudo depmod -a

# load module
echo "Loading module $module_bin"
sudo modprobe -i 8188eu
echo "Done"

# Check if module loaded
lsmod | grep -q 8188eu

# $? is the exit status of the last command, if its 0 then the module loaded
if [ $? -eq 0 ]; then
    echo "Module 8188eu loaded successfully"
else
    echo "Module 8188eu did not load"
fi
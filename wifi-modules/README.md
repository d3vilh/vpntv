# Realtek 8188eu offstaging modules
Here I'll try to explain how to install the Realtek 8188eu offstaging modules on a Raspberry Pi running Raspbian Buster.

Modules build from the [aircrack-ng offstaging branch](https://github.com/aircrack-ng/rtl8188eus) of the Realtek 8188eu driver. The offstaging branch is the most recent branch of the driver and contains the latest fixes and features. The offstaging branch is not yet merged into the master branch of the driver and has additional features that added by [aircrack-ng](https://github.com/aircrack-ng) team.

## Installation
run the following commands to install the driver:
```
sudo apt-get update
sudo apt-get install raspberrypi-kernel-headers
git clone https://github.com/d3vilh/vpntv
cd vpntv/wifi-modules
./install.sh
```
The driver will be installed in `/usr/src/rtl8188eus-1.0` and the kernel module will be installed in `/lib/modules/$(uname -r)/kernel/drivers/net/wireless/rtl8188eu`.

Reboot the Raspberry Pi and the driver should be loaded automatically.
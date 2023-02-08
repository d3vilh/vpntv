# Realtek 8188eu offstaging modules
Builded Linux kernel modules for the Realtek 8188eu chipset. The modules are built for the Raspberry Pi armv61 and armv8 architectures.

Modules build from the [aircrack-ng offstaging branch](https://github.com/aircrack-ng/rtl8188eus) of the Realtek 8188eu driver. The offstaging branch is the most recent branch of the driver and contains the latest fixes and features. The offstaging branch is not yet merged into the master branch of the driver and has additional features that added by [aircrack-ng](https://github.com/aircrack-ng) team.

### Following Linux kernels are supported:
* 5.10.73-v8+ (Raspberry Pi OS 2021-05-07 64-bit) (armv8l)
* 5.10.73+ v71 (Raspberry Pi OS 2021-05-07 32-bit) (armv6l)
  
* 5.15.84-v8+ (Raspberry Pi OS 2021-05-07 64-bit) (armv8l)
* 5.15.84+ v71 (Raspberry Pi OS 2021-05-07 32-bit) (armv6l)

## Installation
Run the following commands to install the driver:
```
sudo apt-get update
git clone https://github.com/d3vilh/vpntv
cd vpntv/wifi-modules
./install.sh
```
Install the kernel headers if you get an error:
```
sudo apt-get install raspberrypi-kernel-headers
```

The driver will be installed in `/usr/src/rtl8188eus-1.0` and the kernel module will be installed in `/lib/modules/$(uname -r)/kernel/drivers/net/wireless/rtl8188eu`.

Reboot the Raspberry Pi and the driver should be loaded automatically.
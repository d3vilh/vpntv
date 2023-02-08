# Realtek 8188eu offstaging modules
Builded Linux kernel modules for the Realtek 8188eu, 8188eus and 8188etv chipsets. The modules are built for the Raspberry Pi armv61 and armv8 architectures.

Modules build from the [aircrack-ng offstaging branch](https://github.com/aircrack-ng/rtl8188eus) of the Realtek 8188eu driver. The offstaging branch is the most recent branch of the driver and contains the latest fixes and features. The offstaging branch is not yet merged into the master branch of the driver and has additional features that added by [aircrack-ng](https://github.com/aircrack-ng) team.

### Following Linux kernels are supported:
* 5.10.73-v8+ (Raspberry Pi OS 2021-05-07 64-bit) (armv8l)
* 5.10.73+ v71 (Raspberry Pi OS 2021-05-07 32-bit) (armv6l)
* 5.15.84-v8+ (Raspberry Pi OS 2021-05-07 64-bit) (armv8l)
* 5.15.84+ v71 (Raspberry Pi OS 2021-05-07 32-bit) (armv6l)

### Following Realtek 8188eu chipsets are supported:
* ID 0bda:8179 Realtek Semiconductor Corp. RTL8188EUS 802.11n Wireless Network Adapter

## Installation
Run the following commands to install the driver:
```
sudo apt-get update
git clone https://github.com/d3vilh/vpntv
cd vpntv/wifi-modules
sudo ./8188eu-install.sh
```
Install the kernel headers if you get an error:
```
sudo apt-get install raspberrypi-kernel-headers
```

The driver will be installed in `/usr/src/rtl8188eus-1.0` and the kernel module will be installed in `/lib/modules/$(uname -r)/kernel/drivers/net/wireless/rtl8188eu`.

Reboot the Raspberry Pi and the driver should be loaded automatically.

## To build the driver from source
Run the following commands to build the driver:

Install the dkms and bc:
```bash
sudo apt install dkms bc
```
**Reinstall** kernel headers:
```
sudo apt reinstall raspberrypi-kernel-headers
```
Clone the drivers repository:
```
git clone https://github.com/d3vilh/rtl8188eus
```
Build the driver:
```
cd rtl8188eus
make
```
Blacklist the official branch of the driver:
```
echo 'blacklist r8188eu'|sudo tee -a '/etc/modprobe.d/realtek.conf'
```
Install the driver:
```
sudo make install
```
Reboot the Raspberry Pi:
```
sudo reboot
```



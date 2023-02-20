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

### List of WiFi adapters compatible with buildin vpntv 8188eus driver:
  <details>
    <summary>
      Compatible list.
    </summary>

  * [Realtek RTL8188EUS](https://www.realtek.com/en/products/communications-network-ics/item/rtl8188eus) Wireless LAN 802.11n USB 2.0 Network Adapter. [Aliexpress link](https://a.aliexpress.com/_Ew27JPn)
  * [Realtek RTL8188ETV](https://www.realtek.com/en/products/communications-network-ics/item/rtl8188etv) Wireless LAN 802.11n USB 2.0 Network Adapter. [Aliexpress link](https://a.aliexpress.com/_EGxet6d)
  * TP-Link TL-WN722N V2/V3 150Mbps High Gain Wireless USB Adapter
  * TP-Link TL-WN727N V5.20 150Mbps Wireless N USB Adapter
  * TP-Link TL-WN725N V3 150Mbps Wireless N Nano USB Adapter
  * EDIMAX EW-7811Un V2 N150 Wi-Fi 4 Nano USB Adapter
  * ASUS USB-N10 Nano B1 USB Adapter Wireless-N
  * D-Link DWA-125 Wireless N 150 USB Adapter(rev.D)
  * D-Link DWA-123 Wireless N 150 USB Adapter(rev.D)
  * D-Link GO-USB-N150 Wireless N 150 Easy USB Adapter(rev.B)
  * D-Link DWA-121 Wireless N 150 USB Adapter(rev.B)
  * Realtek RTL8188EU Wireless LAN 802.11n USB 2.0 Network Adapter
  * 802.11bgn Mini Wireless LAN USB2.0 Adapter
  * ELECOM WDC-150SU2M Wireless Adapter
  * Sitecom WLA-1100 V2 Wi-Fi USB adapter N150
  * MERCUSYS MW150US V2 N150 Wireless Nano USB Adapter
  * Rosewill RNX-N150NUB N150 Wireless Nano USB Adapter
  </details>


## Installation
Run the following commands to install the driver:
```bash
sudo apt-get update
git clone https://github.com/d3vilh/vpntv
cd vpntv/wifi-modules
sudo ./8188eu-install.sh
```
**Reinstall** the kernel headers if you get an error:
```bash
sudo apt remove raspberrypi-kernel-headers;
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
```bash
sudo apt reinstall raspberrypi-kernel-headers
```
Clone the drivers repository:
```bash
git clone https://github.com/d3vilh/rtl8188eu
```
Build the driver:
```bash
cd rtl8188eu
make
```
Blacklist the official branch of the driver:
```bash
echo 'blacklist r8188eu'|sudo tee -a '/etc/modprobe.d/realtek.conf'
```
Install the driver:
```bash
sudo make install
```
or
```bash
chmod +x install.sh
./install.sh -i
```
Reboot the Raspberry Pi:
```bash
sudo reboot
```



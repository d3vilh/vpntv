# vpntv Project
**OpenVPN Client for any TV or TV-box**, provides OpenVPN client running as a service on your Raspberry Pi or any other Linux device. You may use [respberry-gateway](https://github.com/d3vilh/raspberry-gateway) or [openvpn-aws](https://github.com/d3vilh/openvpn-aws) to create your own VPN server and generate client configuration files compatible with this project.

# Requirements
- [**Raspberry Pi Zero W**](https://www.raspberrypi.org/products/raspberry-pi-zero-w/) or [**Raspberry Pi Zero W2**](https://www.raspberrypi.org/products/raspberry-pi-zero-w-2/) board, all with 512Mb RAM minimum.
- [**Raspberry Pi 4**](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/), [**Raspberry Pi CM4**](https://www.raspberrypi.com/products/compute-module-4/?variant=raspberry-pi-cm4001000) **and** [**CM4 I/O Board**](https://www.raspberrypi.com/products/compute-module-4-io-board/) or [**Raspberry Pi 3**](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus/) board, all with 2Gb RAM minimum.
- [**Raspberry Pi Imager**](https://www.raspberrypi.com/software/) to simplify installation of Raspberry Pi OS Lite (32-bit or 64-bit).
- [**Raspios Lite (32-bit)**](https://downloads.raspberrypi.org/raspios_lite_armhf/images/) or [**Raspios Lite (64-bit)**](https://downloads.raspberrypi.org/raspios_lite_arm64/images/) however 32-bit images is recommended for setup on Raspberry Pi Zero boards.
- **16Gb SD Card**
> You can run it on CM4 board with 8Gb eMMC EEPROM chip as well.

# Installation (!PLEASE DONT RUN THIS YET!)
### Development in active process, please don't run this yet!

 ### HW components [preparation steps](https://github.com/d3vilh/vpntv-hardware)
 ### Raspberry Pi OS Lite [installation steps](https://github.com/d3vilh/vpntv-hardware/tree/main/imager-configuration)
 ### Software installation steps
  1. Update your Raspberry Pi OS:
     ```shell
     sudo apt-get update
     sudo apt-get upgrade -y
     ```
  2. Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html):
     ```shell 
     sudo apt-get install -y python3-pip ansible git
     # pip3 install --upgrade pip   # Currently Debian Buster has pip 9.0.1, which is too old for Ansible
     # pip3 install ansible        # Ideally you should use pip3, but it's not available on Debian Buster, you need to build it from source including Rust and Cryptography libraries. That is why we using ansible from repo.
     ```
     > If you'll need updated Rust version (most probably, you do), you can install it from [here](https://www.rust-lang.org/tools/install).
  3. Clone this repository: 
     ```shell
     git clone https://github.com/d3vilh/vpntv
     ```
  4. Then enter the repository directory: 
     ```shell 
     cd vpntv
     ```
  5. Install requirements: 
     ```shell
     ansible-galaxy collection install -r requirements.yml
     ```
     > If you see `ansible-galaxy: command not found`, you have to relogin (or reboot your Pi) and then try again.
  6. Make copies of the configuration files and modify them for your enviroment:
     ```shell
     yes | cp -p example.inventory.ini inventory.ini 
     yes | cp -p example.config.yml config.yml
     ```
  7.  Modify `config.yml` to your needs.
     **To enable** WiFi connection for your TV change `wifi_enable false` option to `wifi_enable true` and vs to disable.
     > **Note**: You cant use both WiFi and Ethernet at the same time, so if you want to use WiFi, you have to disable Ethernet.
  8 Copy your OpenVPN client configuration file to `client-ovpn` directory and rename it to `client.ovpn`.
  9. Modify `inventory.ini` by replace of IP address with your Pi's IP, or comment that line and uncomment the `connection=local` line if you're running it on the Pi you're setting up.
  10. Run installation playbook.
     ```shell
     ansible-playbook main.yml
     ```
> **If running locally on the Pi**: You may have error like `Error while fetching server API version`. You have to relogin (or reboot your Pi) and then run the playbook again.

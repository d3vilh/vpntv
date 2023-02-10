# vpntv Project
**OpenVPN Client for any TV or TV-box**, provides OpenVPN client running as a service on your Raspberry Pi or any other Linux device. You may use [respberry-gateway](https://github.com/d3vilh/raspberry-gateway) or [openvpn-aws](https://github.com/d3vilh/openvpn-aws) to create your own VPN server and generate client configuration files compatible with this project.

# Requirements
- [**Raspberry Pi Zero W**](https://www.raspberrypi.org/products/raspberry-pi-zero-w/) or [**Raspberry Pi Zero W2**](https://www.raspberrypi.org/products/raspberry-pi-zero-w-2/) board, all with 512Mb RAM minimum.
- [**Raspberry Pi 4**](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/), [**Raspberry Pi CM4**](https://www.raspberrypi.com/products/compute-module-4/?variant=raspberry-pi-cm4001000) **and** [**CM4 I/O Board**](https://www.raspberrypi.com/products/compute-module-4-io-board/) or [**Raspberry Pi 3**](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus/) board, all with 2Gb RAM minimum.
- [**Raspberry Pi Imager**](https://www.raspberrypi.com/software/) to simplify installation of Raspberry Pi OS Lite (32-bit or 64-bit).
- [**Raspios Lite (32-bit)**](https://downloads.raspberrypi.org/raspios_lite_armhf/images/) or [**Raspios Lite (64-bit)**](https://downloads.raspberrypi.org/raspios_lite_arm64/images/) however 32-bit images is recommended for setup on Raspberry Pi Zero boards.
- **16Gb SD Card**
> You can run it on CM4 board with 4Gb eMMC EEPROM chip as well.

# Installation (!PLEASE DONT RUN THIS YET!)
At the moment, I have only Raspberry Pi Zero W1 available for developement (all the rest boards are busy with ongoing home automations), that is why it takes a lot of time to test and fix all the issues. 

### Works fine:
* OpenVPN Client installation and configuration
* Wifi hostapd installation

### Still in developement or broken:
* Wifi dongle modules installation **breaks RaspiOS** ಠ╭╮ಠ Work in progress (do not run it yet)
* Ethernet connection is not develpped yet, its planned as next step after I'll fix WiFi modules
* Documentation for [HW configuration](https://github.com/d3vilh/vpntv-hardware) and [RaspiOS installation](https://github.com/d3vilh/vpntv-hardware/tree/main/imager-configuration), both in stailed progress.
* Developement of BeeGo based web-ui for client Certs upload is planned but dev is not started yet

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
     sudo apt-get install -y git ansible
     ```
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
   
  10. Run installation playbook:
     ```shell
     ansible-playbook main.yml
     ```
     > **If running locally on the Pi**: You may have error like `Error while fetching server API version`. You have to relogin (or reboot your Pi) and then run the playbook again.

   11. Reboot your Pi:
       ```shell
       sudo reboot
       ``` 
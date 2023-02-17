# vpntv project
**OpenVPN Client for any TV or TV-boxes**, provides OpenVPN client running as a service on your Raspberry Pi or any other Linux device. You may use [respberry-gateway](https://github.com/d3vilh/raspberry-gateway) or [openvpn-aws](https://github.com/d3vilh/openvpn-aws) to create your own VPN server and generate client configuration files compatible with this project. Supports **Wired** (Ethernet cable) and **Wireless** (WiFi) connection types to your TV.

 <img src="https://github.com/d3vilh/vpntv/raw/main/images/vpntv-wired.png" alt="wired connection" width="350" border="1" /> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img src="https://github.com/d3vilh/vpntv/raw/main/images/vpntv-wireless.png" alt="wireless connection" width="350" border="1" /> 

At the moment project supports WiFi connection only, but Ethernet connection functionality is already in development.

## Requirements
 ### [Hardware Requirements](https://github.com/d3vilh/vpntv-hardware)
 ### [Software Requirements](https://github.com/d3vilh/vpntv-hardware/tree/main/imager-configuration)

 ## vpntv installation steps
  1. Update your Raspberry Pi OS:
     ```shell
     sudo apt-get update && sudo apt-get upgrade -y
     ```
      > **Note**: In case official repositories are not available: `echo "deb http://ftp.agdsn.de/pub/mirrors/raspbian/raspbian/ bullseye main contrib non-free rpi" | sudo tee -a /etc/apt/sources.list` then `sudo apt-get update && sudo apt-get upgrade -y`

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
      <details>
         <summary>
           List of available options
         </summary>

         * **ovpnclient_enable** - enable/disable OpenVPN client service. You need to have OpenVPN client configuration file in `client-ovpn` directory (see next installation step).
  
         * **wifi_enable** - enable/disable VT over WiFi connection. You need to configure here WiFi network name and password of new AP which will be up on vpntv. Used only if you have WiFi dongle connected to your Raspberry Pi. Can't be used with Ethernet connection `ethernet_enable` option at the same time.
  
         * **wifi_mod_enable** - enable/disable custom WiFi modules installation. You need to enable it if your WiFi dongle does not support AP mode by Raspberry Pi OS by default. List of all supported WiFi dongles can be found [here](https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md).
  
         * **ethernet_enable** - enable/disable TV over Ethernet connection. Used only if your TV has Ethernet cable connected to your Raspberry Pi.
      </details>

      > **Note**: You cant use both WiFi and Ethernet at the same time, so if you want to use WiFi, you have to disable Ethernet.

  8. Copy your OpenVPN client configuration file to `client-ovpn` directory and rename it to `client.ovpn`.
   
  9.  Modify `inventory.ini` by replace of IP address with your Pi's IP, or comment that line and uncomment the `connection=local` line if you're running it on the Pi you're setting up.

  10.  Run installation playbook:
   ```shell
      ansible-playbook main.yml
   ```
   > **Note**: If running locally on the Pi, you may have error like `Error while fetching server API version`. You have to relogin (or reboot your Pi) and then run the playbook again.
  11.  Reboot your Pi:
   ```shell
      sudo reboot
   ```

# Active development notification
At the moment it is **in active developement**! I have only Raspberry Pi Zero W1 available for developement (all the rest boards are busy with ongoing home automations), that is why it takes a lot of time to test and fix all the issues. Nevertheless **Testers are welcome!**

## Broken or still in developement features:
* WiFi AP mode is working fine, VPN client connects, DNS resolution works like a charm, but for some reason I can't access internet from my TV. I'm still investigating this issue.
* Ethernet connection is not develpped yet, its planned as next step after I'll got free Raspberry Pi 4 board.
* Documentation for [HW configuration](https://github.com/d3vilh/vpntv-hardware) in stailed progress.
* Developement of BeeGo based web-ui for client Certs upload is planned but dev is not started yet

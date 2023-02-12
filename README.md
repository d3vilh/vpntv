# vpntv project
**OpenVPN Client for any TV or TV-boxes**, provides OpenVPN client running as a service on your Raspberry Pi or any other Linux device. You may use [respberry-gateway](https://github.com/d3vilh/raspberry-gateway) or [openvpn-aws](https://github.com/d3vilh/openvpn-aws) to create your own VPN server and generate client configuration files compatible with this project. Supports Wired (Ethernet cable) and Wireless (WiFi) connection types to your TV.

 <img src="https://github.com/d3vilh/vpntv/raw/main/images/vpntv-wired.png" alt="wired connection" width="350" border="1" /> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img src="https://github.com/d3vilh/vpntv/raw/main/images/vpntv-wireless.png" alt="wireless connection" width="350" border="1" /> 

## Requirements
 ### [Hardware Requirements](https://github.com/d3vilh/vpntv-hardware)
 ### [Software Requirements](https://github.com/d3vilh/vpntv-hardware/tree/main/imager-configuration)

 ## vpntv installation steps
  1. Update your Raspberry Pi OS:
     ```shell
     sudo apt-get update && sudo apt-get upgrade -y
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
     
      > **Note**:  You cant use both WiFi and Ethernet at the same time, so if you want to use WiFi, you have to disable Ethernet.
   
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

# !PLEASE DONT RUN THIS PROJECT YET!
At the moment it is **in active developement**! I have only Raspberry Pi Zero W1 available for developement (all the rest boards are busy with ongoing home automations), that is why it takes a lot of time to test and fix all the issues. Nevertheless **Testers are welcome!**

## Broken features or still in developement:
* Ethernet connection is not develpped yet, its planned as next step after I'll got free Raspberry Pi 4 board.
* Documentation for [HW configuration](https://github.com/d3vilh/vpntv-hardware) in stailed progress.
* Developement of BeeGo based web-ui for client Certs upload is planned but dev is not started yet

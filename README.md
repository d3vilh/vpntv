# VPNTV project
**OpenVPN Client for any TV, TV-boxes or Game Consoles**, provides OpenVPN client running as a service on your Raspberry Pi or any other Linux device. Supports **Wired** (Ethernet) and **Wireless** (WiFi) connection types to your devices. Every VPN provider will have configuration files for openvpn ([Proton](https://protonvpn.com/support/vpn-config-download/), [Nord](https://nordvpn.com/uk/ovpn/), [Surfshark](https://support.surfshark.com/hc/en-us/articles/360003204233-How-to-set-up-OpenVPN-GUI-app-on-Windows-), [Express](https://www.expressvpn.com/support/vpn-setup/manual-config-for-windows-xp-vista-7-8-with-openvpn/)) as well as you may use [respberry-gateway](https://github.com/d3vilh/raspberry-gateway) or [openvpn-aws](https://github.com/d3vilh/openvpn-aws) to create your own VPN server and generate client configuration files compatible with this project.

<img src="https://github.com/d3vilh/vpntv/raw/main/images/vpntv-wireless.png" alt="wireless connection type 1" width="255" border="3" /> <img src="https://github.com/d3vilh/vpntv/raw/main/images/vpntv-wireless2.png" alt="wireless connection type 2" width="255" border="3" /> <img src="https://github.com/d3vilh/vpntv/raw/main/images/vpntv-wired.png" alt="wired connection" width="250" border="3" />

## Requirements
   ### [Hardware Requirements Guide](https://github.com/d3vilh/vpntv-hardware)
   ### [Raspbian Installation Guide](https://github.com/d3vilh/vpntv-hardware/tree/main/imager-configuration)

## VPNTV Software Installation Steps
 When you have your Raspberry Pi with Raspbian OS [installed and configured](https://github.com/d3vilh/vpntv-hardware/tree/main/imager-configuration), you can start with VPNTV installation steps described below:
  1. Login on your Raspberry Pi as `vpntv` user and update your Raspberry Pi OS:
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
  4. Install requirements: 
     ```shell
     cd vpntv && ansible-galaxy collection install -r requirements.yml
     ```
     > If you see `ansible-galaxy: command not found`, you have to relogin (or reboot your Pi) and then try again.

  <details>
    <summary>Continue Installation with WebUI</summary>

  5. Run [Webinstall](https://github.com/d3vilh/vpntv-webconfig) binary:
     ```shell
     secret@rpgw:~/vpntv $ ./webinstall
     2023/07/07 18:01:03 Welcome! The web interface will guide you on installation process.
     Installation logs: webinstall.log
     2023/07/07 18:01:03 Starting web server on http://10.10.10.18:8088
     ```
  6. Copy server address (`http://10.10.10.18:8088` as above example) from the console and paste into your browser, then press Enter. Raspberry-Gateway webinstall window will appear:
     ![Webinstall picture 1](/images/Webinstall-02.png)
  7. Choose all the components you would like to install and change all the passwords (keep them in mind). 
     > **Note**: You can leave all the passwords as default, but it's not recommended.
  8. Press "Save" button. When your configuration is ready, then press "Install" button. It will initiate installation in background:
     ![Webinstall picture 2](/images/Webinstall-03.png)
  9. The installation process will take some time.

  * Additional options:
    * **To Remove** any of previously installed component - click `Uninstall "component"` checkbox then `Save` configuration file and press `Uninstall` button.
    * **To set Default options** for the next `webinstall` run - modify `example.config.yml` with the default parameters. 
    * Default **Ansible parameters**, such as `ansible_user` can be set in `example.inventory.yml` file.
  </details>

  Afraid of GUI? Need more control?

<details>
    <summary>Install everything with CLI</summary>

  5. Make copies of the configuration files and modify them for your enviroment:
      ```shell
      yes | cp -p example.inventory.yml inventory.yml 
      yes | cp -p example.config.yml config.yml
      ```
  6. **Double check** that `ansible_user` is correct for `inventory.yml`. Need to run installtion on the remote server - follow the recomendations in config file.
     
     > **Note**: To make all necesary changes: `nano inventory.yml`, save the file - `Ctrl+O` and `Ctrl+X` to exit.
  7. Modify `config.yml` to **enable** or **disable** desired containers to be installed on your Pi.
     For example, to **enable** Portainer - change `enable_portainer: false` option to `enable_portainer: true` and vs to disable.
     > **Note**: Default configuration options in the list below are **bold**.
      <details>
      <summary>List of available configuration options</summary>

         * **ovpnclient_enable** - enable or disable OpenVPN client service. You need to have OpenVPN client configuration file in `client-ovpn` directory (see next installation step).
         
         * **ethernet2wifi_enable** - enable or disable TV over WiFi connection, while VPNTV connected by Ethernet cable to your home Router. You need to configure here WiFi network name and password of new AP which will be up on vpntv. Prefferable setup. Can't be used with other connection options at the same time.

         * **wifi2wifi_enable** - enable or disable VT over WiFi connection. VPNTV connects to your home WiFi network and create new WiFi network for your TV. You need to configure here WiFi network name and password of new AP which will be up on vpntv. Used only if you have WiFi dongle connected to your Raspberry Pi. Can't be used with other connection options at the same time.
  
         * **wifi_mod_enable** - enable or disable custom WiFi modules installation. You need to enable it if your WiFi dongle does not support AP mode by Raspberry Pi OS by default. [Refer to the list](https://github.com/d3vilh/vpntv/tree/main/wifi-modules) of all supported WiFi dongles.
  
         * **wifi2ethernet_enable** - enable or disable TV over Ethernet connection. Used only if your TV has Ethernet cable connected to your Raspberry Pi. Can't be used with other connection options at the same time.
      </details>


  8. Copy your OpenVPN client configuration file to `client-ovpn` directory and rename it to `client.ovpn`. Here is example of [client.ovpn](https://github.com/d3vilh/vpntv/blob/master/client-ovpn/example-client.ovpn) file configuration. All the parameters of `client.ovpn` depends on your VPN Server configuration. 
      > **Note**: You may use [respberry-gateway](https://github.com/d3vilh/raspberry-gateway) or [openvpn-aws](https://github.com/d3vilh/openvpn-aws) to create your own VPN server and generate client configuration files compatible with VPNTV project. Or go with [Proton](https://protonvpn.com/support/vpn-config-download/), [Nord](https://nordvpn.com/uk/ovpn/), [Surfshark](https://support.surfshark.com/hc/en-us/articles/360003204233-How-to-set-up-OpenVPN-GUI-app-on-Windows-), [Express](https://www.expressvpn.com/support/vpn-setup/manual-config-for-windows-xp-vista-7-8-with-openvpn/), etc profiles.

  9. Run installation playbook: 
     ```shell
     ansible-playbook main.yml
     ```
     > **Note**: **If running locally on the Pi**: You may have error like `Error while fetching server API version`. You have to relogin to your Pi and then run the playbook again.

### To remove VPNTV components
If for some reasons you want to remove one or all VPNTV software components from your Raspberry Pi, you can do it following by these steps:
  1.  Modify `config.yml` to set true components you desired to remove.
     For example, **to remove** WiFi modules - change `wifi_module_remove` option from `false` to `true`.
      <details>
         <summary>
           List of all removal options
         </summary>

         > **Note**: You can remove all components at the same time or do it one by one.
         * **wifi_config_remove** - true/false when `true` - removes all types of VPNTV connections configuration and stop the serives.

         * **wifi_module_remove** - true/false when `true` - removes custom WiFi modules and restore original Realtek 8188 module.
         
         * **ovpnclient_remove** - true/false when `true` - removes OpenVPN client service, configuration and OpenVPN packages.

      </details>

  2.  Run removal playbook:
       ```shell
       ansible-playbook remove.yml
       ```

  3.  Reboot your Pi:
       ```shell
       sudo reboot
       ```
  </details>
  

  10.  Reboot your Pi:
       ```shell
       sudo reboot
       ```

  11.  After the reboot, VPNTV will initiate OpenVPN connection to your VPN server and create WiFi network for your TV. You can connect to it and start using your VPN connection. If your preffered connection option is Ethernet - connect VPNTV to the Ethernet port of your TV and you are ready to go.


<a href="https://www.buymeacoffee.com/d3vilh" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="51" width="217"></a>
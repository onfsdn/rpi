#!/bin/bash

echo "##################################### Starting ###############################"
sudo apt-key update >> /dev/null
sudo apt-get update >> /dev/null
echo "-----------------------------------Done Update--------------------------------"
dpkg -s git 2>/dev/null >/dev/null || sudo apt-get install -y git --fix-missing
dpkg -s minicom 2>/dev/null >/dev/null || sudo apt-get install -y minicom
dpkg -s libpython-dev 2>/dev/null >/dev/null || sudo apt-get install -y --force-yes libpython-dev
dpkg -s python-yaml 2>/dev/null >/dev/null || sudo apt-get install -y --force-yes python-yaml
dpkg -s ipaddr 2>/dev/null >/dev/null || sudo pip install ipaddr
dpkg -s --upgrade six 2>/dev/null >/dev/null || sudo pip install --upgrade six
dpkg -s ryu 2>/dev/null >/dev/null || sudo pip install ryu
dpkg -s debtcollector 2>/dev/null >/dev/null || sudo pip install debtcollector
dpkg -s oslo.i18n 2>/dev/null >/dev/null || sudo pip install oslo.i18n
dpkg -s stevedore 2>/dev/null >/dev/null || sudo pip install stevedore
dpkg -s greenlet 2>/dev/null >/dev/null || sudo pip install greenlet
echo "--------------------Done Installing Dependencies------------------------------"

echo "---------------------Installing Tshark-----------------------------------"
dpkg -s screen 2>/dev/null >/dev/null || sudo apt-get install -y screen --fix-missing
dpkg -s tshark 2>/dev/null >/dev/null || sudo apt-get install -y --force-yes tshark --fix-missing
echo "---------------------Done Installing Tshark---------------------------------"
cd ~/
sudo rm -rf faucet 
git clone https://github.com/onfsdn/faucet >> /dev/null
cd faucet
sudo python setup.py install >> /dev/null
echo "-----------------------------Done Installing Faucet-----------------------------"

echo "-------------Configuring Static IP for OpenFlow Control Plane Netwotk-----------"
sudo sed -i '$a \allow-hotplug eth1 \nauto eth1 \niface eth1 inet static\n\taddress 10.0.1.8\n\tnetmask 255.255.255.0' /etc/network/interfaces
echo "-----------------------Done Configuring Static IP-------------------------------"

mkdir ~/openflow
cd ~/openflow
sudo rm ./faucet.yaml
touch faucet.yaml

sudo sed -i '$a \---\ndp-id: 0x70b3d56cd0c0\n name: "zodiac-fx-1"\nhardware: "ZodiacFX"' ~/openflow/faucet.yaml
echo "Enter DP-id:"
read datapath_response
echo "Enter name:"
read name_response
echo "Enter Hardware:"
read hardware_response
echo "---" >> faucet.yaml
echo "dp_id: 0001" >> faucet.yaml
echo "name: '1'" >> faucet.yaml
echo "hardware: 'Allied-Telesis'" >> faucet.yaml


echo "DP-id:$data_response"
echo "name:$name_response"
echo "hardware:$hardware_response"
sed -i "s/.*dp_id.*/dp_id: $datapath_response/g" ~/openflow/faucet.yaml
sed -i "s/.*name.*/name: $name_response/g" ~/openflow/faucet.yaml
sed -i "s/.*hardware.*/hardware: $hardware_response/g" ~/openflow/faucet.yaml
sed -i '$a \interface:\n 1:\n  native_vlan:100\n 2:\n  native_vlan:100\n 3:\n  native_vlan:100\nvlans:\n 100:\n  name: "100"' ~/openflow/faucet.yaml

touch start-faucet.sh
echo "#!/bin/bash" >> ~/openflow/start-faucet.sh
sed -i '$a \export FAUCET_CONFIG=~/openflow/faucet.yaml' ~/openflow/start-faucet.sh
sed -i '$a \export FAUCET_LOG=~/openflow/faucet.log' ~/openflow/start-faucet.sh
sed -i '$a \export FAUCET_EXCEPTION_LOG=~/openflow/faucet_exception.log' ~/openflow/start-faucet.sh
sed -i '$a \screen -S FaucetController -d -m /usr/local/bin/ryu-manager --verbose --config-file=~/faucet/src/ryu_faucet/org/onfsdn/faucet/ryu-faucet.conf --ofp-listen-host =10.0.1.8 --ofp-tcp-listen-port=6663 ~/faucet/src/ryu_faucet/org/onfsdn/faucet/faucet.py' ~/openflow/start-faucet.sh

#sed '$a \#!bin/bash' ~/openflow/start-faucet.sh
#echo " Starting Faucet Controller ..." >> ~/openflow/start-faucet.sh
#sudo screen -S FaucetController -d -m /usr/bin/ryu-manager --verbose --ofp-tcp-listen-port 6653 ~/faucet/src/ryu_faucet/org/onfsdn/faucet/faucet.py >> ~/openflow/start-faucet.sh
#echo " Starting Gauge Controller ..." >> start-faucet.sh
#sudo screen -S GaugeController -d -m /usr/bin/ryu-manager --verbose --ofp-tcp-listen-port 6654 ~/faucet/src/ryu_faucet/org/onfsdn/faucet/gauge.py >> ~/openflow/start-faucet.sh
#echo "Listing Screen process ..." >> ~/openflow/strat-faucet.sh
#sudo screen -list
#echo "To attach to a running screen process run:"
#echo "  screen -r FaucetController"
#echo "  screen -r GaugeController"

chmod +x start-faucet.sh
echo "-------------------------------------Done---------------------------------------"

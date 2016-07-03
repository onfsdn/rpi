## Raspberry Pi as a Faucet Controller ##

This document describes the use of Raspberry Pi to Configure and Test the Zodiac FX Switch.

### Requirements: ###
- Raspberry Pi 3
- Zodiac FX Switch
- USB to Ethernet Cable Compatible with Raspberry pi 
	
### Firmware Upgrade For Zodiac FX ###

Download the following Files:

- Zodiac FX User guide [[download link]](http://forums.northboundnetworks.com/downloads/zodiac_fx/guides/ZodiacFX_UserGuide_0216.pdf)
- Atmel SAM-BA In-System Programmer [[download link]](http://www.atmel.com/tools/atmelsam-bain-systemprogrammer.aspx)
- Firmware Bin File [[download link]](http://forums.northboundnetwoks.com/index.php?topic=267.0)

Follow the Zodiac FX userguide to update the Firmware.

**Important:** if you are upgrading from 0.57 or below you must run  the "factory reset" command (in config mode) after updating the firmware and then restart the switch to re-align the config ROM.

### Installation ###

Clone this repository and run the below commands.
	
- GIT clone our repository.
- Run ./Install_Faucet.sh
- Enter DP ID:
- Enter Name:
- Enter Hardware:
- Click Done

On RPi Terminal Enter

- cd /home/pi/openflow
- Then Run  ./start_faucet.sh


when code is executed following script will appear on screen



	loading app /home/pi/faucet/src/ryu_faucet/org/onfsdn/faucet/faucet.py
	loading app ryu.controller.ofp_handler
	instantiating app None of DPSet
	creating context dpset
	 app /home/pi/faucet/src/ryu_faucet/org/onfsdn/faucet/faucet.py of Faucet
	instantiating app ryu.controller.ofp_handler of OFPHandler
	BRICK dpset PROVIDES EventDPReconnected TO {'Faucet': set(['dpset']) 
	PROVIDES EventDP TO {'Faucet': set(['dpset'])
	CONSUMES EventOFPPortStatus
	 CONSUMES EventOFPSwitchFeatures
	CONSUMES EventOFPStateChange
	BRICK Faucet
	CONSUMES EventOFPPortStatus	
	CONSUMES EventOFPSwitchFeatures
	CONSUMES EventFaucetResolveGateways
	CONSUMES EventOFPErrorMsg
	CONSUMES EventFaucetReconfigure
	CONSUMES EventFaucetHostExpire
	  CONSUMES EventOFPPacketIn
	CONSUMES EventDPReconnected
	CONSUMES EventDP
	BRICK ofp_event
	  PROVIDES EventOFPPortStatus TO {'dpset': set(['main']), 'Faucet': set(['main'])}
	  PROVIDES EventOFPErrorMsg TO {'Faucet': set(['main'])}
	PROVIDES EventOFPSwitchFeatures TO {'dpset': set(['config']), 'Faucet': set['config'])}
	  PROVIDES EventOFPStateChange TO {'dpset': set(['main', 'dead'])}	
	PROVIDES EventOFPPacketIn TO {'Faucet': set(['main'])}
	CONSUMES EventOFPEchoReply
	CONSUMES EventOFPPortStatus
	  CONSUMES EventOFPErrorMsg
	CONSUMES EventOFPSwitchFeatures
	CONSUMES EventOFPPortDescStatsReply
	CONSUMES EventOFPHello
	CONSUMES EventOFPEchoRequest
	EVENT Faucet->Faucet EventFaucetResolveGateways
	EVENT Faucet->Faucet EventFaucetHostExpire	
	connected socket:<eventlet.greenio.base.GreenSocket object at 0x75cdc210> address:('10.0.1.99', 49946)
	hello ev <ryu.controller.ofp_event.EventOFPHello object at 0x75cdc910>
	move onto config mode	
	EVENT ofp_event->dpset EventOFPSwitchFeatures
	EVENT ofp_event->Faucet EventOFPSwitchFeatures	
	switch features ev version=0x4,msg_type=0x6,msg_len=0x20,xid=0x5ce4692f,OFPSwitchFeatures(auxiliary_id=0,capabilities=7,datapath_id=123917682135232L,n_buffers=0,n_tables=10)
	move onto main mode
	EVENT ofp_event->dpset EventOFPStateChange
	DPSET: register datapath <ryu.controller.controller.Datapath object at 0x75cdc510>
		EVENT dpset->Faucet EventDP

  



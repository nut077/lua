-- file : config.lua

local module = {}

module.SSID = {}  
module.SSID["Bunyawat"] = "1234509876"

-- module.HOST = "test.mosquitto.org" 
module.HOST = "192.168.0.15"  
module.PORT = 1883  
module.ID = node.chipid()

module.ENDPOINT = "nodemcu/lua/"  
return module  

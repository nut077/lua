-- file : config.lua

local module = {}

module.SSID = {}  
module.SSID["Waraporn"] = "panpan2007"

module.HOST = "test.mosquitto.org"  
module.PORT = 1883  
module.ID = node.chipid()

module.ENDPOINT = "nodemcu/lua/"  
return module  

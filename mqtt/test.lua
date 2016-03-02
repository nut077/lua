-- file : test.lua

app = require("led_control_application")  
config = require("config")  
setup = require("setup")

setup.start()  

-- dofile("test.lua")
-- mosquitto_sub -h test.mosquitto.org  -p 1883 -t nodemcu/lua/# -v
-- mosquitto_pub -h 192.168.1.3 -p 1883 -t nodemcu/lua/10394073 -m "led0/off"
-- mosquitto_pub -h 192.168.1.3 -p 1883 -t nodemcu/lua/10394073 -m "led0/on"
-- mosquitto_sub -h 192.168.0.15 -p 1883 -t nodemcu/lua/# -v

-- file : application.lua

local module = {}  

LED_A = 0
gpio.mode(LED_A, gpio.OUTPUT)

LED_B = 1
pwm.stop(LED_B)
pwm.setup(LED_B, 500, 0)
pwm.start(LED_B)

function blink(data)

    print("data: -" .. data .. "-")
    
    if ("led0/off" == data) then
        gpio.write(LED_A, 1)
        print("LED OFF")
    elseif ("led0/on" == data) then 
        gpio.write(LED_A, 0)
        print("LED ON")
    else 
        range = string.sub(data, 6, -1)
        print("LED PWM "..range)
        pwm.setduty(LED_B, tonumber(range))
    end

end

m = nil

-- Sends a simple ping to the broker
local function send_ping()  
    m:publish(config.ENDPOINT .. "ping","id=" .. config.ID .. ":bunyawat",0,0)
    print("Publish to data endpoint")
    print(config.ENDPOINT .. "ping")
end

-- Sends my id to the broker for registration
local function register_myself()  
    m:subscribe(config.ENDPOINT .. config.ID,0,function(conn)
        print("Successfully subscribed to data endpoint")
        print(config.ENDPOINT .. config.ID)
    end)
end

local function mqtt_start()  
    
    m = mqtt.Client(config.ID, 120)
    
    -- register message callback beforehand
    m:on("message", function(conn, topic, data) 
      if data ~= nil then
        print(topic .. ": " .. data)
        -- do something, we have received a message
        blink(data)
      end
    end)
    
    m:on("connect", function(con) 
        register_myself()
        -- And then pings each 1000 milliseconds
        -- tmr.stop(6)
        -- tmr.alarm(6, 1000, 1, send_ping)
    end) 

    -- Connect to broker
    m:connect(config.HOST, config.PORT, 0, 1)

end

function module.start()  
  mqtt_start()
end

return module  

print(wifi.sta.getip())
--nil
wifi.setmode(wifi.STATION)
wifi.sta.config("Waraporn","panpan2007")
print(wifi.sta.getip())

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload) 
        --print(payload)  
        i,j=string.find(payload, "/d0/on", 1)
        pin=0
        gpio.mode(pin,gpio.OUTPUT)
        if (i==nil) then       
           print("off")
           gpio.write(pin,gpio.HIGH)
            conn:send("<h1> D0 : OFF </h1>")
        else
           print("on")
           gpio.write(pin,gpio.LOW)
           conn:send("<h1> D0 : ON </h1>")
        end
    end) 
end)
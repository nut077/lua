
print("\ncontrol LED vie HTTP")
print("format http://"..wifi.sta.getip().."/write/3/0")
print("format http://"..wifi.sta.getip().."/write/3/1")
print("format http://"..wifi.sta.getip().."/write/4/0")
print("format http://"..wifi.sta.getip().."/write/4/1")
print("format http://"..wifi.sta.getip().."/toggle/200")
print("format http://"..wifi.sta.getip().."/read")



pin1=3
pin2=4
gpio.mode(pin1,gpio.OUTPUT)
gpio.mode(pin2,gpio.OUTPUT)


function trunOffAll()
    gpio.write(pin1, 0)
    gpio.write(pin2, 0)
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function urlencode(payload)
    result = {};
    list=split(payload,"\r\n")
    --print(list[1])
    list=split(list[1]," ")
    --print(list[2])
    list=split(list[2],"\/")

    table.insert(result, list[1]);
    table.insert(result, list[2]);
    table.insert(result, list[3]);

    return result;
end

function sendHeader(conn)
     conn:send("HTTP/1.1 200 OK\r\n")
     conn:send("Access-Control-Allow-Origin: *\r\n")
     conn:send("Content-Type: application/json; charset=utf-8\r\n")
     conn:send("Server:NodeMCU\r\n")
     conn:send("Connection: close\r\n\r\n")
end

function toggle()
 
    if (gpio.read(pin1) == 1) then
        gpio.write(pin1, 0)
        gpio.write(pin2, 1)

    else
        gpio.write(pin1, 1)
        gpio.write(pin2, 0)

    end

end


trunOffAll()
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
      list=urlencode(payload)

      
      if (list[2]=="write") then
      
        tmr.stop(0)
        
        local pin = tonumber(list[3])
        --print("Pin: "..pin) 
        local status = tonumber(list[4])
        --print("State: "..status)
        gpio.write(pin, status)
        -- Response Header
        sendHeader(conn) 
        -- Response Content
        conn:send("{\"result\":\"ok\",\"digitalPin\": "..pin..", \"status\": "..gpio.read(pin).."}")
      elseif (list[2]=="toggle") then

        print("call toggle")
      
        -- Response Header
        local delay_time = tonumber(list[3])

        tmr.alarm(0, delay_time, 1, toggle)
        
        sendHeader(conn) 
        -- Response Content
        conn:send("{\"result\":\"ok\",\"toggle\": \"true\", \"delay\": "..tostring(delay_time).."}")
      elseif (list[2]=="read") then
        -- Response Header
        sendHeader(conn) 
        -- Response Content
        conn:send("{\"result\":\"ok\", \"digitalPins\": [{\"digitalPin\": "..pin1..", \"status\": "..gpio.read(pin1).."},{\"digitalPin\": "..pin2..", \"status\": "..gpio.read(pin2).."}]}")
      else
        -- Response Header
        sendHeader(conn) 
        -- Response Content
        conn:send("{\"result\":\"error\",\"message\": \"command not found\"}")        
      end
      conn:close()
    end) 
end)
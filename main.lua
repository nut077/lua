ssid = 'Bunyawat'
pwd = '1234509876'
print("set up wifi mode")
wifi.setmode(wifi.STATION) 
wifi.sta.config(ssid, pwd)
wifi.sta.connect()
cnt = 0

MAX_LOOP = 10
DELAY_TIME = 1000

tmr.alarm(0, DELAY_TIME, 1, function() 
        if (wifi.sta.getip() == nil) and (cnt < MAX_LOOP) then 
          print("IP unavaiable, Waiting...")
          cnt = cnt + 1 
        else 
          tmr.stop(0)
          if (cnt < MAX_LOOP) then 
               print("Config done, IP is "..wifi.sta.getip())
               tmr.alarm(0, DELAY_TIME, 1, function() 
                    tmr.stop(0)
                    print("WIFI connected...")
                    -- dofile("tcp_client_temp.lc")
                    -- dofile("sample_http3.lua")
                    -- dofile("iothink_weather.lc")
               end) 
          else 
               print("Wifi setup time more than 10s, Please verify wifi.sta.config() function. Then re-download the file.")
          end
        end 
end)
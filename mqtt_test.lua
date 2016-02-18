


m = mqtt.Client(node.chipid(), 120)

-- setup Last Will and Testament (optional)
-- Broker will publish a message with:
-- qos = 0, retain = 0, data = "offline" 
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/lwt", "offline", 0, 0)

m:on("connect", function(con) print ("connected") end)
m:on("offline", function(con) print ("offline") end)

-- on publish message receive event
m:on("message", function(conn, topic, data) 
  print(topic .. ":" ) 
  if data ~= nil then
    print(data)
  end
end)

-- for secure: m:connect("192.168.11.118", 1880, 1)
m:connect('test.mosquitto.org', 1883, 0, function(conn) 
    print("connected") 
end)


-- stop here before call as block







-- subscribe topic with qos = 0
m:subscribe("nodemcu/lua",0, function(conn) 
    print("subscribe success") 
end)




-- publish a message with data = hello, QoS = 0, retain = 0
m:publish("nodemcu/lua","hello from bunyawat",0,0, function(conn) 
    print("sent") 
end)

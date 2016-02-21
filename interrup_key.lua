pin = 1
led = 0

gpio.mode(pin,gpio.INT)
gpio.mode(led,gpio.OUTPUT)

function pin1cb(level)

  print(level)

  if level == gpio.HIGH then 
    gpio.write(led, gpio.HIGH)
    gpio.trig(pin, "down") 
  else 
    gpio.write(led, gpio.LOW)
    gpio.trig(pin, "up") 
  end
end
gpio.trig(pin, "down", pin1cb)
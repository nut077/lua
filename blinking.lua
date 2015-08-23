
LED = 7
DELAY_TIME = 1000

gpio.mode(LED, gpio.OUTPUT)
tmr.alarm(0, DELAY_TIME, 1, function() 
    if (gpio.read(LED) == 1) then
        gpio.write(LED, 0)
        print("LED OFF")
    else
        gpio.write(LED, 1)
        print("LED ON")
    end
end)
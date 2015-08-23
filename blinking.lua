
LED = 3
DELAY_TIME = 1000


function blink()

    if (gpio.read(LED) == 1) then
        gpio.write(LED, 0)
        print("LED OFF")
    else
        gpio.write(LED, 1)
        print("LED ON")
    end

end

gpio.mode(LED, gpio.OUTPUT)
tmr.alarm(0, DELAY_TIME, 1, blink)


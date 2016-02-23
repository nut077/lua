
RED = 1
GREEN = 2
BLUE = 5


pwm.stop(RED)
pwm.stop(GREEN)
pwm.stop(BLUE)

pwm.setup(RED, 500, 0)
pwm.setup(GREEN, 500, 0)
pwm.setup(BLUE, 500, 0)

pwm.start(RED)
pwm.start(GREEN)
pwm.start(BLUE)

function led(r, g, b)
    pwm.setduty(RED, r)
    pwm.setduty(GREEN, g)
    pwm.setduty(BLUE, b)
end

direc = 1
color = 1
i = 0

function blink() 

    if color > 3 then
        color = 1
    end

    if direc == 1 then
        if i < 500 then
            i = i + 5
        else
            direc = 0
             print("chang direction "..0)
        end
    else
        if i > 0 then
            i = i - 5
        else
            direc = 1
            print("chang direction "..1)
            color = color + 1
            print(color)
        end
    end
    
    if color == 1 then
        led(i,0,0)
    elseif color == 2 then
        led(0,i,0)
    else
        led(0,0,i)
    end       
   
end

tmr.alarm(0, 50, 1, blink)



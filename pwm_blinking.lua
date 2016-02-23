
LED = 1

pwm.stop(LED)
pwm.setup(LED, 500, 0)
pwm.start(LED)


direc = 1
i = 0
function blink() 
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
        end
    end
    pwm.setduty(LED, i)

end

tmr.alarm(0, 50, 1, blink)


pwm.stop(1)
pwm.setup(1, 500, 100)
pwm.start(1)


function led(r, g, b)
    pwm.setduty(1, r)
    pwm.setduty(2, g)
    pwm.setduty(3, b)
end



direc = 1
i = 0
function blink() 
    if direc == 1 then
        if i < 300 then
            i = i + 20
        else
            direc = 0
             print("chang direction "..0)
        end
    else
        if i > 0 then
            i = i - 20
        else
            direc = 1
            print("chang direction "..1)
        end
    end
    led( i, 0, 0 )
    print( i )
end

tmr.alarm(0, 500, 1, blink)
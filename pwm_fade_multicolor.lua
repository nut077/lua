
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

    if r < 0 then r = 0 end
    if g < 0 then g = 0 end
    if b < 0 then b = 0 end
    
    pwm.setduty(RED, r)
    pwm.setduty(GREEN, g)
    pwm.setduty(BLUE, b)

    print(r .. " " .. g .. " " .. b) 
end


direction = 1
step = 1
brightness = 512

red_color = brightness;
green_color = brightness;
blue_color = brightness;

MAX_BRIGHT = 512
MIN_BRIGHT = 0
BRIGHT_STEP = 30

function fade() 

    if step == 1 then
        red_color = MAX_BRIGHT
        blue_color = MIN_BRIGHT
        brightness = brightness - BRIGHT_STEP
        green_color = brightness
    elseif step == 2 then
        red_color = MAX_BRIGHT
        green_color = MIN_BRIGHT
        brightness = brightness + BRIGHT_STEP
        blue_color = brightness
    elseif step == 3 then
        green_color = MIN_BRIGHT
        blue_color = MAX_BRIGHT
        brightness = brightness - BRIGHT_STEP
        red_color = brightness
    elseif step == 4 then
        red_color = MIN_BRIGHT
        blue_color = MAX_BRIGHT
        brightness = brightness + BRIGHT_STEP
        green_color = brightness
    elseif step == 5 then
        red_color = MIN_BRIGHT
        green_color = MAX_BRIGHT
        brightness = brightness - BRIGHT_STEP
        blue_color = brightness
    elseif step == 6 then
        green_color = MAX_BRIGHT
        blue_color = MIN_BRIGHT
        brightness = brightness + BRIGHT_STEP
        red_color = brightness
    end



    if (brightness >= MAX_BRIGHT) or (brightness <= MIN_BRIGHT) then
        step = step + 1
        if step > 6 then
            step = 1
        end
    end

    led(red_color, green_color, blue_color)
   
end

tmr.alarm(0, 100, 1, fade)



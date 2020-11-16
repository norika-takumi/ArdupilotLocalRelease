-- example of getting RC input and override sticks


local copter_loiter_mode_num = 5
local copter_auto_mode_num = 3

function set_mode_loiter()
  local mode = vehicle:get_mode()         -- get current mode
  if mode == copter_auto_mode_num then    -- change to loiter mode
    vehicle:set_mode(copter_loiter_mode_num)
  end
end


function update()


  pwm1 = rc:get_pwm(1)
  pwm2 = rc:get_pwm(2)
  pwm3 = rc:get_pwm(3)
  pwm4 = rc:get_pwm(4)


  dead_up = 60
  dead_down = 60
  local mode = vehicle:get_mode() 

  if mode == copter_auto_mode_num then  
    if ((pwm1 > (1500 + dead_up)) or (pwm1 < (1500 - dead_down))) then
      set_mode_loiter()
    end
    if ((pwm2 > (1500 + dead_up)) or (pwm2 < (1500 - dead_down))) then
      set_mode_loiter()
    end
    if ((pwm4 > (1500 + dead_up)) or (pwm4 < (1500 - dead_down))) then
      set_mode_loiter()
    end
  end
  return update, 1000 -- reschedules the loop
end

return update()

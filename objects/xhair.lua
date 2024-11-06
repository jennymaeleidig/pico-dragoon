function new_xhair()
  local xhair = {}
  xhair.pos = v_new(59,80)
  xhair.bnds = {{0, 120},{-3,92}}
  xhair.v = v_new(0,0)
  xhair.spd = 2

  xhair.update = function(this)
    if btn(0) then
      xhair.v = v_addv(xhair.v, v_new(-2,0))
    end
    if btn(1) then
      xhair.v = v_addv(xhair.v, v_new(2,0))
    end
    if btn(2) then
      xhair.v = v_addv(xhair.v, v_new(0,-2))
    end
    if btn(3) then
      xhair.v = v_addv(xhair.v, v_new(0,2))
    end
    xhair.pos = bound_obj(v_addv(xhair.pos, xhair.v), xhair.bnds)
    xhair.v = v_new(0,0)
  end 
   
  xhair.draw = function(this)
    palt(15,true)
    palt(0,false)
    spr(1,xhair.pos.x,xhair.pos.y)
    palt()
  end
  return xhair
end

function init_xhair()
  xhair = new_xhair()
end
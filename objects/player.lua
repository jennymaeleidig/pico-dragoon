function new_player()
    local plr = {}
    plr.pos = v_new(43,90)
    plr.bnds = {{1,87},{72, 99}}
    plr.spd = 1
    plr.v = v_new(0,0)
    -- animation
    plr.sprs = {drg_blu_spr_top, drg_blu_spr_mid, drg_blu_spr_bot}
    plr.spr = 2
  
    plr.update = function(this)
      if btnp(5) then
        fire_proj()
      elseif btn(5) then
        loc_cnt += 1
      else
        loc_cnt = 0
      end 
      if btn(0) then
        plr.v = v_addv(plr.v, v_new(-plr.spd,0))
      end
      if btn(1) then
        plr.v = v_addv(plr.v, v_new(plr.spd,0))
      end
      if btn(2) then
        plr.v = v_addv(plr.v, v_new(0,-plr.spd))
      end
      if btn(3) then
        plr.v = v_addv(plr.v, v_new(0,plr.spd))
      end
      plr.pos = bound_obj(v_addv(plr.pos, plr.v), plr.bnds)
      plr.v = v_new(0,0)
      -- update sprite
      if (frame % 12 == 0) then
        plr.spr = (plr.spr == 3) and 1 or plr.spr + 1
      end
    end
  
    plr.draw = function(this)
      spr_rle(plr.sprs[plr.spr],plr.pos.x,plr.pos.y)
    end
  
    return plr
  end
  
function init_player()
  loc_tim = 20
  loc_cnt = 0
  plr = new_player()
end

function fire_proj()
  add(projs, new_proj())
end
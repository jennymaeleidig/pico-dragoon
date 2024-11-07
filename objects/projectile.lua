function new_proj()
  local proj = {}
  proj.pos = v_new(plr.pos.x+17, plr.pos.y)
  proj.v = v_subv(xhair.pos, proj.pos)
  --get normalized proj vector
  proj.v = v_normalize(proj.v)
  proj.ttl = 30

  proj.update = function(this)
    proj.ttl -= 1
    -- update position based on vector
    proj.pos = v_addv(proj.pos, v_mults(proj.v, 2.5))
  end
  
  proj.draw = function(this)
    palt(15,true)
    palt(0,false)
    if proj.ttl < 30 and proj.ttl > 24 then
      spr(3,proj.pos.x,proj.pos.y)
    elseif proj.ttl < 24 and proj.ttl > 10 then
      spr(4,proj.pos.x+1,proj.pos.y+1)
    else
      spr(5,proj.pos.x+2,proj.pos.y+2)
    end
    palt()
  end
  
  return proj
end

function update_projs()
  for obj in all(projs) do
    obj.update(obj)
    if obj.ttl < 0 then
      del(projs, obj)
    end
  end
end

function draw_projs()
  for obj in all(projs) do 
    obj.draw(obj)
  end
end

function init_projs()
  projs = {}
end

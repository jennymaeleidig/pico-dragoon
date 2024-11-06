-- helper functions ------------------
function slp(o1,o2)
  return (o2[2]-o1[2]) / (o2[1]-o1[1])
end

function dst(o1,o2)
  return sqrt(sqr(o1[1]-o2[1])+sqr(o1[2]-o2[2]))
end

function sqr(x) return x*x end

-- shallow copy ----------------------
function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function bound_obj(pos, bnds)
  pos.x = (pos.x <= bnds[1][1]) and bnds[1][1] or pos.x
  pos.x = (pos.x >= bnds[1][2]) and bnds[1][2] or pos.x
  pos.y = (pos.y <= bnds[2][1]) and bnds[2][1] or pos.y
  pos.y = (pos.y >= bnds[2][2]) and bnds[2][2] or pos.y
  return pos  
end
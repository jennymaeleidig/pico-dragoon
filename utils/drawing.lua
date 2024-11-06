-- draw triangle ---------------------
function pelogen_tri_low(l,t,c,m,r,b,col)
    color(col)
    while t>m or m>b do
        l,t,c,m=c,m,l,t
        while m>b do
            c,m,r,b=r,b,c,m
        end
    end
    local e,j=l,(r-l)/(b-t)
    while m do
        local i=(c-l)/(m-t)
        for t=flr(t),min(flr(m)-1,127) do
            rectfill(l,t,e,t)
            l+=i
            e+=j
        end
        l,t,m,c,b=c,m,b,r
    end
    pset(r,t)
end
 	
-- print text x centered --------------
function prinx(t,y,c)
  return print(t,64-#t*2,y,c)
end
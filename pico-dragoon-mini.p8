pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init()
  init_assets()
  init_menu()
  init_ui()
  init_gnd_ptn()
  init_player()
  init_projectile()

  frame = 0
  horizon = 67
  dragon = ""
  scene = "main_menu"
  in_stage = false
end
 
function _update60()
  if scene == "main_menu" then
    update_main_menu()
  elseif scene == "blue_drag" then
    update_blue_drag()
  elseif scene == "black_drag" then
    update_black_drag()
  elseif scene == "red_drag" then
    update_red_drag()
  elseif in_stage then
    if scene == "stage1" then
      update_stage1()
    end
    update_ui()
    update_player()
    update_projectile()
  end
  frame +=1
end
 
function _draw()
  if scene == "main_menu" then
    draw_main_menu()
  elseif scene == "blue_drag" then
    draw_blue_drag()
  elseif scene == "black_drag" then
    draw_black_drag()
  elseif scene == "red_drag" then
    draw_red_drag()
  elseif in_stage then
    if scene == "stage1" then
      draw_stage1()
    end
    draw_projectile()
    draw_ui()
    draw_player()
    
  end
end

-- custom lifecycle functions ----------

-- inits -------------------------------
function init_assets()
  main_menu = explode64(main_menu_str)
  drag_blue = explode64(drag_blue_str)
  drag_black = explode64(drag_black_str)
  drag_red = explode64(drag_red_str)
  stg_1_bg = explode64(stg_1_bg_str)
  drg_blu_spr_mid = explode64(drg_blu_spr_mid_str)
  drg_blu_spr_bot = explode64(drg_blu_spr_bot_str)
  drg_blu_spr_top = explode64(drg_blu_spr_top_str)
end

function init_player()
  plr_pos = {43,90}
  plr_bnds = {{1,87},{72, 99}}
  plr_spd = 1
  plr_sprs = {drg_blu_spr_top, drg_blu_spr_mid, drg_blu_spr_bot}
  plr_spr = 2
end

function init_ui()
  init_xhair()
end

function init_xhair()
  xhair_pos = {59,80}
  xhair_bnds = {{0,120},{-3,92}}
  xhair_spd = 2
end

function init_menu()
  loaded_blue = false
  loaded_red = false
  loaded_black = false
  loaded_main = false
end

function init_gnd_ptn()
  gnd_ptn_fwd = {{{1,3},{10,17},{28,47},{64,64}},
  {{3,5},{13,20},{38,60},{64,64}},
  {{0,0},{4,8},{17,26},{48,60}},
  {{0,2},{6,12},{20,37},{64,64}}}
  gnd_ptn_fwd_i = 1
end

function init_projectile()
  proj_fired = false
  proj_ttl = 30
  proj_pos = {0,0}
  proj_slope = 1
end

-- draw / updates ----------------------

function update_projectile()
  if btnp(5) and not proj_fired then
    proj_fired = true
    proj_pos = {plr_pos[1]+16,plr_pos[2]-3}
    proj_slope_y = abs(xhair_pos[2]-proj_pos[2])
    proj_slope_x = xhair_pos[1]-proj_pos[1]
    printh(proj_slope_x)
    printh(tostr(proj_pos[1])..", "..tostr(proj_pos[2]))
  end
  if proj_fired then
    proj_ttl -= 1
    if frame % 3 == 0 then
      proj_pos = {proj_pos[1]+proj_slope_x,proj_pos[2]-proj_slope_y}
      printh(tostr(proj_pos[1])..", "..tostr(proj_pos[2]))
    end
  end
  if proj_ttl == 0 then
    proj_ttl = 30
    proj_fired = false
    proj_pos = {0,0}
    proj_slope = 1
  end
end

function draw_projectile()
  palt(15,true)
  palt(0,false)
  if proj_fired then
    if proj_ttl < 30 and proj_ttl > 20 then
      spr(3,proj_pos[1],proj_pos[2])
    elseif proj_ttl < 20 and proj_ttl > 5 then
      spr(4,proj_pos[1]+1,proj_pos[2]+1)
    else
      spr(5,proj_pos[1]+2,proj_pos[2]+2)
    end
  end
  palt()
end

function update_player()
  if btn(0) then
    plr_pos[1] = (plr_pos[1] <= plr_bnds[1][1]) and plr_bnds[1][1] or plr_pos[1] - plr_spd
  end
  if btn(1) then
    plr_pos[1] = (plr_pos[1] >= plr_bnds[1][2]) and plr_bnds[1][2] or plr_pos[1] + plr_spd
  end
  if btn(2) then
    plr_pos[2] = (plr_pos[2] <= plr_bnds[2][1]) and plr_bnds[2][1] or plr_pos[2] - plr_spd
  end
  if btn(3) then
    plr_pos[2] = (plr_pos[2] >= plr_bnds[2][2]) and plr_bnds[2][2] or plr_pos[2] + plr_spd
  end
  if (frame % 12 == 0) then
    plr_spr = (plr_spr == 3) and 1 or plr_spr + 1
  end
end

function draw_player()
  spr_rle(plr_sprs[plr_spr],plr_pos[1],plr_pos[2])
end

function update_ui()
  update_xhair()
end

function draw_ui()
  draw_xhair()
end

function update_xhair()
  if btn(0) then
    xhair_pos[1] = (xhair_pos[1] <= xhair_bnds[1][1]) and xhair_bnds[1][1] or xhair_pos[1] - xhair_spd
  end
  if btn(1) then
    xhair_pos[1] = (xhair_pos[1] >= xhair_bnds[1][2]) and xhair_bnds[1][2] or xhair_pos[1] + xhair_spd
  end
  if btn(2) then
    xhair_pos[2] = (xhair_pos[2] <= xhair_bnds[2][1]) and xhair_bnds[2][1] or xhair_pos[2] - xhair_spd
  end
  if btn(3) then
    xhair_pos[2] = (xhair_pos[2] >= xhair_bnds[2][2]) and xhair_bnds[2][2] or xhair_pos[2] + xhair_spd
  end
end

function draw_xhair()
  palt(15,true)
  palt(0,false)
  spr(1,xhair_pos[1],xhair_pos[2])
  palt()
end

function update_stage1()
  if (frame % 6 == 0) then
    gnd_ptn_fwd_i = ((gnd_ptn_fwd_i == 4) and 1 or (gnd_ptn_fwd_i + 1))
  end
end

function draw_stage1()
  cls()  
  
  -- Default stage 1 pallete
  pal({[0]=7,12,1,140,0,9},1)

  -- Stage one Pallete blue dragon
  pal({[0]=7,12,1,140,0,9,129,6,5},1)
   --new colors, maybe only set once 
  draw_rle(stg_1_bg,0,0)

  rectfill(0, horizon, 127, 127, 2)
  -- need to reset pallete based on stage
  -- pal()
  for i = 1, count(gnd_ptn_fwd[gnd_ptn_fwd_i]) do
    rectfill(0, horizon+gnd_ptn_fwd[gnd_ptn_fwd_i][i][1], 127, horizon+gnd_ptn_fwd[gnd_ptn_fwd_i][i][2], 3)
  end
end

function update_red_drag()
  if loaded_red then
    if btnp(4) then
      loaded_red = false
      scene = "main_menu" 
    elseif btnp(0) then
      loaded_red = false
      scene = "blue_drag"
    elseif btnp(5) then
      loaded_red = false
      scene = "stage1"
      in_stage = true
    end
  end
end

function draw_red_drag()
  if not loaded_red then
    cls()
    loaded_red = true
    draw_rle(drag_red,0,0)
    pelogen_tri_low(14, 110, 4, 100, 14, 90, 8)
    print("red", 8, 8, 8) 
  end
end

function update_black_drag()
  if loaded_black then
    if btnp(4) then
      loaded_black = false
      scene = "main_menu" 
    elseif btnp(1) then
      loaded_black = false
      scene = "blue_drag"
    elseif btnp(5) then
      loaded_black = false
      scene = "stage1"
      in_stage = true
    end
  end
end

function draw_black_drag()
  if not loaded_black then
    cls()
    loaded_black = true
    draw_rle(drag_black,0,0)
    pelogen_tri_low(113, 110, 123, 100, 113, 90, 5)
    print("black", 8, 8, 5)
  end
end

function update_blue_drag()
  if loaded_blue then
    if btnp(4) then
      loaded_blue = false
      scene = "main_menu" 
    elseif btnp(1) then
      loaded_blue = false
      scene = "red_drag"
    elseif btnp(0) then
      loaded_blue = false
      scene = "black_drag"
    elseif btnp(5) then
      loaded_blue = false
      scene = "stage1"
      in_stage = true
    end
  end
end

function draw_blue_drag()
  if not loaded_blue then
    cls()
    loaded_blue = true
    draw_rle(drag_blue,0,0) 
    pelogen_tri_low(14, 110, 4, 100, 14, 90, 12)
    pelogen_tri_low(113, 110, 123, 100, 113, 90, 12)
    print("blue", 8, 8, 12)
  end
end

function update_main_menu()
  if btnp(5) then
    scene = "blue_drag"
    loaded_main = false
  end
end

function draw_main_menu()
  if not loaded_main then
    cls()
    loaded_main = true
    draw_rle(main_menu,0,0)
  end
  rectfill(0,112,127,128,0)
  if (band(frame,32)!=0) then
    prinx("press x to start",115,8)
  end
end

-- helper functions ------------------

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

-- string asset loading functions -----
function explode64(s)
 local retval,lastpos,i = {},1,2
 while i <= #s do
  add(retval,base64decode(sub(s, lastpos, i)))
  lastpos = i+1
  i += 2
 end
 return retval
end

function explode_hex(s, delimiter)
 local retval,i=split(s,delimiter,false)
 for i=1,#retval do
  retval[i] =("0x"..retval[i])+0
 end
 return retval
end

function base64decode(str)
 val=0
 for i=1,#str do
  c=sub(str,i,i)
  for a=1,#base64str do
   v=sub(base64str,a,a)
   if c==v then
    val *= 64
    val += a-1
    break
   end
  end
 end
 return val
end

-- optimized rle drawing functions
-- big thanks to frederic souchu
-- ( @fsouchu on twitter )
-- for the help
function spr_rle(table,_x,_y)
 local x,y,i,w=_x,_y,3,table[1]+_x
 for i=3,#table do		
  local t=table[i]
  local col,rle = (t& 0xff00)>>8
                  ,t& 0xff
  if col!=15 then
   rectfill(x,y,x+rle-1,y,col)
  end
  x+=rle
  if x >=w then
   x = _x
   y += 1
  end
 end
end

function spr_rle_flip(table,_x,_y)
 local w=table[1]
 local x,y,i,x2=_x+w,_y,3,_x+w
 for i =3,#table do
  local t=table[i]
  local col,rle = (t& 0xff00)>>8
                  ,t& 0xff 
  if col!=15 then
   rectfill(x-rle+1,y,x,y,col)
  end
  x-=rle
  if x <=_x then
   x = x2
   y += 1
  end
 end
end

function draw_rle(table,_x,_y)
local x,y,i,w=_x,_y,3,table[1]+_x
 for i=3,#table do
  local t=table[i]
  local col,rle = (t& 0xff00)>>8
                  ,t& 0xff
  rectfill(x,y,x+rle-1,y,col)
  x+=rle
  if x >=w then
   x = _x
   y += 1
  end
 end
end

function setpal(palstr)
 local i,palindex
 palindex=explode_hex(palstr,",")
 for i=1,#palindex do
  pal(i-1,palindex[i],1)
 end
end

-- large assests / constants ----------
base64str='0123456789abcdefghijklmnopqrstuvwxyz!@#$%^&*()_-+=[]}{;:<>,./?~|'
main_menu_str="2020201es40_1bs30[19s40]17s50}0s/50@s60}0r}1/70ns605s70}0qk1/90ls804s80]0p}1/c0hsb04s203s307s101s101s101s101s201s201s201s301s301si0ok1/e0fsc02s406s106s101s101s101s101s201s201s201s301s301si0o/3}101k1/a0bsm0cs101s101s101s101s201s201s201s301s301si0f/4k102}1/20c}1/309so0bs101s101s101s101s201s201s201s301s301si0dk1/602/20bk1}101}1/20fsj0as101s101s101s101s201s201s201s301s301si0c}1/701k1/1}10bk1/1}1k1}1/10hs802sa07s101s101s101s101s201s201s201s301s301si0b/9}101}10ck1}1/101}1/10js602sf0)0a/b}20g/20ls304s602s40-09/5k3/3}1/20e!101/20ls205s60{08/3k105/60ck1!201/20ts201s30}0h/60c}1!202k10xs30]0h/60ak1}1k1!1k1}1/1}10ys20]0h/60bk1!2k1/20!s30=0h/609k1/1}1!1k1/20$s30-0h/609}1k101k1/2}10%s30_0h/607k1}1k1/3}11r0h/606k1/5}11s0h/606/5k11t0h/605/51v0h/605/3k11w0h/604}1/1k11y0h/604/106}1/20c/3k10b}1/5}10>0h/60a/5}108/7}1k106k1/7}1/20:0h/50a/5}108/302k1/406/7}1/40;0h/3k1/1k108}1/507k1/305/304}1/603/1k1/2}10{0h/2k1}1/207}1/508/307/1}1/103/2k1/307}1/20}0h/2k2/209}1/1}1/106k1/2k107k1/1}1/102k1/5k107/30}0h/2}2/209/406k1/2k107/2}103/4k208k1/30]0h/2}1/309/405/3}10e/40a/40]0h/609/405/3k10e/40a/40]0h}1/1}1/309/405/40a/103/40a/40]0h}1/1}2/209/40441/409/203/30bk1/30]0h/2}1/302}205/404k1/408/303/30a/2k1/20]0h}101k1/3k1/206/404/54107/303}1/20a/3k10}0h/1k1/5}107/1}1/20441/4}107/304/209/4}10}0hk1/608/2k2/1}103/1}1/2}1k106/205/307/50{0h/608/2k1/101}104/4k141k1/607}1/2k104/3}10:0h/4}108}1/3k1/105k1/2k3/608k1/9}1/10:0h/3}108}1/507k1/1!101}1k1/40ak1/80>0h/2k10b/2}10bk101k101k10ek1/5k10>20200h}1/2}10c}1/104/509/b03/dk105}1/5}102k1/70p0a/204/4k1/209/301k1/7}108/a04k1/c}103k1/7}1/201}1/707/207}1/20509/303/501/2}107/401}2k1/608/2}1k1/507k105k1/404/7k2/301k1/804/405/40508/402/2}1k1/201/504}1/406/408/1}102/4}106/1}106}1/2k102}1/701k1/1k101/1}1k1/1k103k1/2k103/504/40506/601/203k1/101/602}1/506/408/103/505/207k1/1}103/2k1/3}102/301}1/206k1/202/703/40505}1/607k2/401}1/103}1/306/3k107/1k103k2/304/307/203k1/5k103/4k1/207/301/705/20504}1/709/703/406/307/202/4k1/204/208/1}101/101/4k204/4k1/306/302}1/505/20503k1/809/301/303/406/207k1/201/6k105/20a/201/505/4k1/306/303/505/20502k202}1/509k1/201/402/406/108/301/101}1/504/20a/201/406/301/405k1/303/5!104/20506k1/50a/2}101/302/405}1k107k1/301/102/503k1/209/301/406/301/405/4}102/201/1k101k1}102/20506}1/50a/3}1/302/404k109/404/503/308/401/406/2}1k1/404k1/4k102/201/202}1k101/20506k1/50a/4k1/202/403/3!106/504k1/3}103/405/601/307/201/504/1k3/103/202k1/1}1k1}2/20506}1/50a/702/403}1/306/505k101/1}103/405k1/501}1/207/201/405/503/203/202!1/20506}1/50a/1}1/502/404/504/505!101/1}103/506/303/207/201/3}103/604/203k1/102!1/30406k1/50a/2}1/3k102/5}102/8k1/5}104k101/104/5}105/204/305}1/3k1/202/7}104/206!2/50206}1/50a/2k1}1/203/4}104}1/502/5}106}2k102k1/703k106}1/2k1}1/3k1/2}101k1/8}105/403!2k1/40306k1/50a/2k2/203/406/403/506}205/1}1/906k1/8k1}1/a}106/3k104/5k10306k1/50a/2k3/103/307/2}104/4k106/1}105/1k1/808k1/801/9k107/305k1/3k10406k1/50a/201/101}103/1}108/205k1/2k107}107k1/5k10ck1/5k103k1/5k108/1}107k1/1k10506}1/50ak101k1/1}11@06}1/50ak2}1/21@06}1/50ak1}11%06}1/509/2}203+a410f+94101+a4101+84108+84101+a410d06k1/508/3k1}10341+9410f+84102+a4101+94107+84101+a410d06}1/508/30641+9410d+8410341+8410241+84107+7410241+8410e06k1/507k1/3k106+9410d+8410441+6410441+74107+6410441+6410f06k1/507/3}107+9410d+84105+64105+84106+64105+6410f06}1/506k1/308+a410b+94105+64105+84106+64105+6410f06k1/506/3k108+a410b+94105+64105+84106+64105+6410f06}1/505k1/309+a410a+a4105+64105+94105+64105+6410f06k1/505/30a+a410a+a4105+64105+94105+64105+6410f06k1/504/2}10b+a410a+a4105+64105+94105+64105+6410f06k1/3}203}1/20c+b4108+b4105+64105+a4104+64105+6410f06}1/503/20d+b4108+b4105+64105+a4104+64105+6410f06k1/502k20e+c4107+b4105+64105+a4203+64105+6410f06k1/60h+c4106+c4105+64105+b4103+64105+6410f06k1/60h+c4106+c4105+64105+b4103+64105+6410f06}1/5}10h+d4105+c4105+64105+c4102+64105+6410f06k1/4}10i+d4104+d4105+64105+c4102+64105+6410f06/4k10j+741+64103+641+64105+64105+d4101+64105+6410f06/2}10l+741+64103+641+64105+64105+d4101+64105+6410f05k1/20m+741+64102+741+64105+64105+641+64101+64105+6410f0u+742+64101+642+64105+64105+641+741+64105+6410f0u+74101+64101+64101+64105+64105+642+641+64105+6410f0u+7410141+c4102+64105+64105+64101+d4105+6410f0u+74102+c4102+64105+64105+6410141+c4105+6410f0u+74102+b4202+64105+64105+6410141+c4105+6410f0u+7410241+a4103+64105+64105+6410241+b4105+6410f0u+74103+a4103+64105+64105+6410241+b4105+6410f0u+74103+94203+64105+64105+6410341+a4105+6410f0u+74103+94104+64105+64105+6410341+a4105+6410f0u+7410341+74204+64105+64105+6410441+94105+6410f0u+74104+74105+64105+64105+6410441+94105+6410f0t+8410441+54205+74104+64105+6410541+84105+6410f0s+94105+54106+84102+84103+7410641+84103+8410e0s+94105+54106+84101+a4101+8410641+94101+a410d0s+9410541+34206+84101+a4101+8410741+84101+a410d0t4906440847024b0248074a014b0d2020202020202020202020202020202020202020"
drag_blue_str="2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200g421_0b8202890144+3430941k2sa}2150i8801810244+24303k1sg}2130k8a0342+541slo1410541}40j44+341+2460j0m8b0343+1so4101k1s9}10d44+142014201814101448141k1430e0n8d4101}1s#}10647+14101428h}1k1410c0p880143}1o1s%410242+1410241038k0g0q85014202k1}1s&410141+142038l0i0r82014105}1sv+2sbk142+14101+5428f0j0w83o1sw+7o1s5}10148+142+2428a0k0x}1sfo4sao1s1o3+ao1+302440143k1830244+2k1830k0wk1s9o2}2s4o7s1o1s2o7+141+94301460343870241+141k1810j0ws9}1k4s3o4}1o1}2obk142+241+442+1420242038202428606430h0v}1s7o1}1k341}1s4o3}5o8}241+143+44706850141k1830r0uk1s6o1}1k243k1o1s5o2}6o6}341+341+141+244+24204418701420s0tk1s5o1}1k24203}1s3o1s1o4}5o4}1o1}441+143+34902420a410r0ts4}1k3420441s3o2s1o4}7o1}1o2}3k145+141+14a02410c410p0r}1s4o1k24106k1s4o7}5k1}2o1}5k141+1410142+142044106}40z0ro1s2}1k2410641s4o9}3k1g18141k1}6k141+141+1034101o1s1k3o1s2}2s6o1430u0@42}1o2s1o9}241g2o101g1k142}20146+144s9o141o1s1o1}1+1s2o1410v0@42k1o6s1o4}141+141g2s101g1k142s2}144+146sa41o3}1+1s1o1}10w0@42k1}1o1s2o6}1+241+1g28101g141+141}102410143+442s4o1s541}441o2k10w0@42k1}1o945g281018143s2}1410148o1s3o1s6k1}1k341o1k10x0@42k1}1o7+146g38141+142s2}1410142+143+141o1s3o1s6k1}1k1410141}10y0@43}1o5}1+346g34301s2}1410143+144o2s1}1s7k1o14102k20y0#42}1o3}1+142+1440244+143s2}1410144+3k1o1}2o1s7k202410!0$41k1}1+245+144054202s2}147+141k1}1k1}1o1s7}1410$0^4c0143014103}1s2k149k3}1s8410%0*490143+14104}1s24b01}1o1s80^0*4g03}1s2440144014101}2s7o10^0~s34301420541}1o1s7o10^0~s34304410341}1o1s5o1s1o10^0(420g}1o1}14309o1s5o1}1k1}10^0(41k50d}10c41}1o1s4o1}1k1410^0(k5410b}1s1}1k10ck1}1o1s1o2}2k1410^0*41k50c}1s2}1094102k1}1o4}1k2410^0(}3k20c}1s2410241034105k2}1o2}2k2420%0(k1}3k10cs302420941k1}1o1}2k14201420$0)o1}1k10ds2k101430a42k34203410$0)o20d}1o1k10143+10i430$0|43+20j+1410$0|42+141+10e44+1430#0|43+1410d42+141+2420$0~460d42+441+1410#0|440e42+4410%0~450e41+241+1420%0~440f41+5410%0>480g+141+40^0>470g41+141+40^0:44+142+1410g44+30^0:44+4410f42+141+4410%0;42+6420f41+141+5410%0}44+3450f42+70%0*41+641+243+5420g42+8410#0*42+547+50g42+a0#0*44+242+141+143+4420e+441+8410@0z460b41+143+141+1430b43+141+3440141+141+1410!0^430842+144+1420g42+1430441+1410@0{41+24101420d41k14103430341k102420@0wk1410j420i440241+141044102+1410@0v41}1410)4208410#0v}14107411n0v4107k1o11n0$}1411n18k10b420&2020202020202020202020202020"
drag_black_str="20202020202020202020202020202020202020202020202020202020202020202020202020202020202020200-k2}1s4o1190(41k1}1s4o1k21a0&k1o2s3o2k20f41k1o1s1k10<0$k1o1s6o1}1k10fk1o1s3k10>0@k1o1s7o1k20e41o1s4o10,0zo1s7o1}1k1410dk1o1s5}1k10.0r41k1}1k24101k1s7o1}1k10d41o1s5o1}1k10/0q}1s2o1s3}1o1s6o1}1k10es1o1s3o2}1k1410/0pk1o1s2o1s2o2s6o1}1k1}1k1410a41k1s5}1k2410?0o41s1o1}1o4}1o1s5o1}1o1s2o1k10441o1k10241}1s4o2k2410~0ok1s1o1}1o2}2o1s2o8s1o2k1}1k2}1s241k1o1s5o1k241o1s1k10/0ok1}1o1s3o4}1o6s6o2}1o1s2o2s5o1}1k142s3o1410,0ok1o1s4o4sf}1o1s1o2s4o2}1k3s2o1s30641k3410-0m42k1}1s2o4sio1}1o1s5o1}1k14101k1o6}104}1o2s3410_0n42}1o4sko3s3o2}1k10241k2}2k1o3k102k3}1s2o1s1410)0l44k1}1o1smo2s3o2}1k103410141k4}1o201k1o1}1k2o2k1o2410(0k4202o3sboa}3o3}1k30241k3410143k5o3k1}1o1k4410*0j420281}1o1s5od}6k1o2}2k241034301k302k3}1o1s4o1}1k34102410%0i430181g1}1o2s1o6}2o1}ak1}1k1}1o3k241034101410142k10141o101k2}1o1s4o1}1k1420241k10%0h4101410181!1g1o4}1o3}dk1}1k3}1s1o1k24101}1k109k1s2o1k1}1o1s4o1}1k24101450#0h420181!2k1o1s3o3}1ki}1s1}1k141k1s2o1k107k142}1s1o1}1o1s4o1}1k141k141k10143k10@0h4102!3k1s5o3}1kk41k1o2s3o1064201k4o2s3o1}1k141k142k141k1420@0i4181!2g1k1o1s5o2}1kk}1o2s6410541024101k1}1o4}2k1410242k34201420x0jg1!2g1k1s6o3}1k742k9}1o4s1o1s4o14104410143k1}1o2}2k14101g1!1g10142k141k101420x0h4101!3g1k1s7o2}2k743k7o2s1o1s2o2s5o14104k102k3}2k24101!4g1814301k101410w0g4101g1!4k1s7o2}2k744k5o1s5o1}1o1s7}1014101k14102k64181!78142k14102k1410t0ig1!4k1o1s6o2}2k74401k3}1o2s2o1kb4102k101}14102k541!ak142k1024101410r0ig1!4k1o1s5o3}3k74181410141k3s2o2ka4101420242014102k4!ck142k1}14102k10q0nk1o1s6o3}2k6g181018201k1o2s1o1}1k84201k2o1}1k1}1o2}2o1k5!fg14101k20r0nk1o1s6o3}2k44181!181o1018101k1}1o3k7430141k1}1o141k1o3}1k1}1k101k3!hg141k241k101k10m0nk1}1s6o4}2k24101g1!181}1018102k1}3k54303k2o1k2}1o3}1k202k3!jg101k20o0n41}1o1s5o4}1k581!181028103k1}1k54304k341k1o3}3410281g1k1!lk141k10n0oo2s6o3k142k1410181!1g101820341k54206k241k1}1o3}1k24103g1k1!n4103410j0o}1o1s5o4034301g2830341k4410842k2}1o3}1k2410381g2!mg10n0oo2s6o1k10241024103g18105k1}2k2410941k1}1o2}3k24104g1!p81k2430g0ok1}1s5k1}103k10ck2}2k24109k1}2o2}2k34105!qg10k0p41o1}2k1420g41k1}2k30842}2o3k54106k10585g1!fk1410h0r4501k10do1k4}1k14102420441k1o1s3o1k50n82g1!9g141k10f0-o1k2}2k2410241k105k1o1s4}1k14102410r81g1!7k101410d0*k1o1}1k7410a41}1o1s3}1k1410#81g1!1g10d0*k1}1o1}141k2}2k1410bk1o1s3k2410:0)}1o1k102k3014209k1}1s2o1k20)k141090_k24101k241k30ak1o3k1410_41090-k201k241k2410ak2}2k14104410]0+41024201k2}10a4402410;0]42}102410d41k2410;0]k14101410fk241k101410}0[4101420g4401410}1643k10;0{410gk201410;0+410l4401410}0-}10141k1410k4101k1410}0*43044101k1410g41k143k10}0!42k40542k10141k10g42014101410{0!43k2014106k10j41k101420;0zk34102410b410g41}102k3410[0t42k54102410142k106410i410343k1410[0s42k1420a41k103k10k45k4410=0(k102410k4101k141k1450[0z4109k1410i4301k1410141k142k141k10=0y410ak10i430143k402410[0)410g4103420241k103}14101410=0m41k10{410[0m41k10@41k241034107410]0?k241100tk21x0s41}1411x202020200,k1150,k11520202020202020202020202020"
drag_red_str="20202020202020202020202020202020202020202020202020202020202020202020202020202020201s}1s4k103}1o1s1o3s9o1s1}1091uk1o1s3o1sfo1s2k1091i}1s3o1}106k2o1sko1k1091hk1s6}103k2}2k1o1sjo10a1bk105}1s7o3}102k101k1s4o1se}10a0=81w1810hk1}1s5o1}1k102o1s8o4}103o1si0b0[w3810e}1s7o302o1s9o2s1o1}1k3o1sh0b0[81w2o1s2o1k108}1o1sb}101o1sao3s1o201k1o1s4o1sa}10b0]81}1s5o105k1o1sd}1k1o1sco2s2}101k1}1sdo10c0&o1}108o1s4o2s4o2seo1}1o1sdo1}1s4o2sbo1k10c0*s3k105}1o1}1w1o1s4o1}1o1sfo1k1}1sfo2sd}10f0*}1s305k1}1w2o1s3o1k1o1sgk101k1sfo1}3o1s9}10g0(o1s305k181k1o1s2o101k1o1s6o3s1o1s4o1w2k1o1sfo1}1k2o1s6o1k10h0(}1s404k3}1o2k1w1}1o1s5o1}4w8o2sgo1}102}1s6o10h0)o1s305k2}3w2}2o5wcs1o2sgo2}1k101}1s5o10h0)k1s3}105k1}1k101w1k1}4o2wcs3}1sho2}1k101k1o2}1k10i0^k302o1s3k105k20181k6wds2}2o1sho2}1k10n0!k2}1o5k101k1o1s305k10281k1}3s1o181wa81}1s1o1k1}1o1sio2}1k10m0uk1}2oc}101}1s3}104}2k181k1w581w981w1s2k101}1sko2}1k10l0kk3}3o9sb}1k1o1s3k102o1s3wg81w1}1o1k101}1sno1}20k09}1s#}1s4k1o2s1o1}1wd81w282}3spo2}20j0bo1s!o1s4o1s3o1}1wd82w182}2sro2k10j0d}1szo1s4o1s2o1}1w881w484k3o3soo2k10j0fk1}1sw}1o1s3o1s2o1}183w582w286k1}1o5sno1}1k10i0j}1su}1s3o1s2o1}1k285k185018203}1o6sn}1k10i0lk1}1o1sqo2s3o1s1o1}2o2k1}1o3}109k1}2o1}1o3s1o2sk}1k20h0pk1}1so}1s3o1s1o1k1o1s2o2s1o1}10a}6o6sj}1k20h0tk1spo2}1k1o1s3o1s1o1k106k1}1o1s1o1}5o6sj}1k20h0xk1}1o1sjo1}1k101o1s4}1o1}102k1o1s8}7o4s1o1sgk30h0%k4}8s3o1k102o1s4o1}3o1sa}7o9sdk30h0{k204o1s5o1}1k1o1sb}9oas9}1k20h0.o1s5o1}1k2}1o1s9o1}bo7s9}1k20h0.o2s5}2k2}2o2s7o1}ao8s8}1k20h0.o2s5o1}1k102k1}3o1s6}bo7s7o1}1k20h0.}1o1s5o1}205k2}2o1s2o1}1k1}2k2}6o6s7o1}1k20h0.}1o2s5}20a}1o1}1k5}9o6s4o2}1k10i0,81}1o2s5o1}1k107k2}1o28302k1}5o1}1o9s2o2k20i0,w1}2o1s6}1k106k101k2o284!101k1}7o8s3o1k20i0>82k1}2o1s4o1}1k107k101k1o2k183%10181}6o9s1o3}1k10i0,81k2}2o1s3o1}108k101k1o2k183%182!181}5ock20i0,w101k2}2o3}1k10bo2}184!181%1w3k1}2ob}1k20i0>81w181k2}6k108k102}1o1}1w184%1!181w282}1o2}1o6}3k20i0,8201k2}5k10b}1o281w18aw1}1o2}3o3}3k20i0,81w18101k2}2k20c}1o281w38bo5}1o2}2k10j0.w381k40dk1o2k1w388w182w1}2o6}10k0.w6810ek1o2k1w48bw2}1o4}1k10k0.w6810ek1s1o1}1w68cw182k20l0.w70fo3w78dw1810m0.w6810f}1o281w682w4860p0.w482w1810ek1o2}1w484w9810p0.w381w1840e}1o1}1w3840184w4k1}1k20n0.w8820e}1o1w381w1830184w28102k1}2k10l0.w481w3820fk1w381w185w182w18105k20l0,w6850g82w186w2830t0>81w9810k85w2810w0>wa820k82w3810x0<81wb810l81w30y0<wa830m81w1810ik20e0<w9840m830ik1}20d0<81w8860*k20c0<81w683w5820:0<81w781w581w1810:0<81w283w183w28102820wk20l0<81w1810381w182w18104810x}1k10k0<82058101820$k1o10k0>8108810%k10k202017k20:20202020201ak10{0?k10c}10{0?}10c}10{0?k1122020202020202020202020"
stg_1_bg_str="2020606060606060606060606060606060606060606060606060606060604x055a034d4m044408580a484l07410a510h41064606470m4~0p0d4102410q4.0q0e420s4,0q0f420s4>0q0=4{0q0=4;0p0j410s4:0p0j420r4,0m0j480l4,0m0l4a0c45034,0j0l4h0249024?0g0m4m04520e0n4h014109500d0n4g0d4|0d0n4e0i4?0c0n4e0i4?0c0o4a0p4.0a0n4a0s4>0a0n490u4,080o460w4h094y060p420z4e0e4w060?4f0k4q060|4c0o4o05104a0r4n0410480u4k0610470v4j0711440&4103410c20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"
drg_blu_spr_mid_str = "0%0u/%/%/%/iw1s2/j/hs103s1w1/h/gg1s101s102g1/h/gw6c1g1/g/gw2s102w3/gg1w2s1w1s1w1g2w141c3g1w1c1s104c1w1c1g141c141c141s5w1s1g2/5k1w2s1w2g2c2g1s205w2c1g2w3s2k1/6/dg2s2w2s3w3/f/ew101s1w1s101s2g1s2/f/ew4s102s1w3/f/eg3w1s4w1g2/f/ec141w1g1c143g1c141c1/e/dw1c1g1w2s102c1g3c1g1/d/dc1g4s102s1g1w1g2w1/d/dw2g1w1g1w1s1w2g5/d/ec3g2s141/1g1c141w1/e/dc1g2c1g1w101s1/1g1w1g1w1g1/d/dg6c1w1/1g4c1/d/cc2g1w1c1g1/1c1g1/1g1c4g1/c/cg1w1g2w1/2g1/2g1w1g2w1g1/c/bg1w2/1g1w1g1/4g1w1g2w2g1/b/bw2g1/1w2g1/4g1w1g1/1g1w1g1/b/bg3/1g3/4g3/1g3/b/%/%/%/%"
drg_blu_spr_top_str = "0%0u/%/%/%/3g1w1/uw1g1/3/4w1g1w1/bw1s2/bg1w2/5/6w1s1w1/8s103s1w1/7g1w1s1w1/6/7w1s1w1c1/5g1s101s102g1/5g141g1w1/8/9w1g142g1/2w6c1g1/2c141w1g1/a/bw2c1w1/1w2s102w3/141c1w2/b/bg3c3s104w1c141g1w1/d/eg2w1s105g2/f/fs2w2s3w3/f/ew101s1w1s101s2g101s1/f/ew4s102s1w3/f/eg3w1s4w1g2/f/ec141w1g1c143g1c141c1/e/dw1c1g1w2s102c1g3c1g1/d/dc1g4s102s1g1w1g3/d/dw2g1w1g1w1s1w2g4w1/d/ec3g2s141/1g1c141w1/e/dc1g1c2g1w101s1/1g1w1g1w1g1/d/dg6c1w1/1g4c1/d/cc2g1w1c1g1/1c1g1/1g1c4g1/c/cg1w1g2w1/2g1/2g1w1g2w1g1/c/bg1w2/1g1w1g1/4g1w1g2w2g1/b/bw2g1/1w2g1/4g1w1g1/1g1w1g1/b/bg3/1g3/4g3/1g3/b/%/%/%"
drg_blu_spr_bot_str = "0%0u/%/%/%/iw1s2/j/hs103s1w1/h/gg1s101s102g1/h/gw6c1g1/g/gw2s102w3/g/gc1s104w2/g/fc1w1s105w1/g/ec1s2w2s3w1s141/f/dg1s101s1w1s101s2g1s241w1/d/bg1w1g1w3s202s1w3g3/c/bc1g2w1g2w1s4w1g3w2g1/b/ag141g2c141w1g1c143g1c141c1g1w1s1w1/a/9w1c1g1/1w1c1g1c1g1s102c1g3c1g1/1w2/a/8g1c1g1/2c1g3w1s102s1g1w1g3/2w2/9/8c1k1/3w2g3w1s1w2g4w1/3k1g1/8/7c1w1/5c3g2s141/1g1c141w1/5w1g1/7/6c1g1/5c1g1c2g1w101s1/1g1w1g1w1g1/5g1w1/6/6g1/6g6c1w1/1g4c1/6g1/6/5g1/6c2g1w1c1g1/1c1g1/1g1c4g1/6g1/5/cg1w1g2w1/2g1/2g1w1g2w1g1/c/bg1w2/1g1w1g1/4g1w1g2w2g1/b/bw2g1/1w2g1/4g1w1g1/1g1w1g1/b/bg3/1g3/4g3/1g3/b/%/%/%/%"
__gfx__
00000000ff0000ffff5555ffff444ffff444fffff4ffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff44440fff44445ff40004ff40004fff404fffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004ffff4054ffff454077774f40774ffff4ffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004ffff4054ffff454077884f40784fffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004ffff4054ffff454078884ff444ffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004ffff4054ffff45f47884ffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000f04444fff54444ffff444fffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff0000ffff5555ffffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000

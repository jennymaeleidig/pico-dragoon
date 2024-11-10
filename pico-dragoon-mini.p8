pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

#include ./utils/vectors.lua
#include ./utils/string_assets.lua
#include ./utils/drawing.lua
#include ./utils/helpers.lua
#include ./assets/menu.lua
#include ./assets/dragons.lua
#include ./assets/stages.lua
#include ./objects/xhair.lua
#include ./objects/projectile.lua
#include ./objects/player.lua
#include ./objects/ui.lua
#include ./lifecycles/main_menu.lua
#include ./lifecycles/character_select.lua
#include ./lifecycles/stage.lua
#include ./lifecycles/stages/stage_1.lua

function _init()
  poke(0x5f5c,255)
  init_char_select()
  init_player()
  init_stage()
  frame = 0
  scene = "main_menu"
end
 
function _update60()

  if scene == "main_menu" then
    update_main_menu()
  elseif is_in(scene, drag_scenes) then
    update_char_select()
  elseif scene == "stage1" then
    update_stage()
  end
  frame +=1
end
 
function _draw()
  if scene == "main_menu" then
    draw_main_menu()
  elseif is_in(scene, drag_scenes) then
    draw_char_select()
  elseif scene == "stage1" then
    draw_stage()
  end
end

__gfx__
00000000ff0000ffff5555ffff444ffff444fffff4ffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff44440fff44445ff40004ff40004fff404fffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004ffff4054ffff454077774f40774ffff4ffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004ffff4054ffff454077884f40784fffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004ffff4054ffff454078884ff444ffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004ffff4054ffff45f47884ffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000f04444fff54444ffff444fffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000ff0000ffff5555ffffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000

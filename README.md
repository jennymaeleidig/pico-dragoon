# Pico Dragoon Mini (Work In Progress)

My interpretation of [Panzer Dragoon Mini](https://www.youtube.com/watch?v=7rkUTJOvT_U) for the Sega Game Gear implemented in pico-8.

Panzer Dragoon Mini was never released in the United States. In order to bring this game to a larger audience, I am working to port the game to the pico8 ecosystem to allow for broader access.

## Setup
* Clone Repo into `/carts` directory
* Load `pico-dragoon-mini.p8` file in pico.
* Run and enjoy!

## Development Notes

### Main

Hosts system lifescycle functions (`init()`, `update60()`, `draw()`).

### Utils

* `drawing` - Hosts custom drawing functions for shapes outside of standard library.
* `helpers` - Hosts custom math functions as well as other utilies.
* `string_ssets` - Hosts functions to draw larger assets. See this [post](https://www.lexaloffle.com/bbs/?tid=38884) for further detail.
* `vectors` - Simple vector math library. Currently uses [this](https://github.com/clowerweb/Lib-Pico8/blob/master/vectors.lua) implementation. For more complex calculations, [this]() library could be useful.

### Objects

Each object follows a general stucture of having the following lifecycle functions:

```lua
function new_obj()
  local obj = {}
  -- init logic

  obj.update = function(this)
  -- update logic
  end
  
  obj.draw = function(this)
  -- draw logic
  end
  
  return obj
end
```

### Assets

Static asset files as described in the `Utils` section, `string_assets` subsection above.

### Lifecycles

Hosts the individual "rooms" of the game.


function update_char_select()
    if scene == "blue_drag" then
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
    elseif scene == "black_drag" then
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
    elseif scene == "red_drag" then
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
end

function draw_char_select()
    if scene == "blue_drag" then
        if not loaded_blue then
            cls()
            loaded_blue = true
            draw_rle(drag_blue,0,0) 
            pelogen_tri_low(14, 110, 4, 100, 14, 90, 12)
            pelogen_tri_low(113, 110, 123, 100, 113, 90, 12)
            print("blue", 8, 8, 12)
        end
    elseif scene == "black_drag" then
        if not loaded_black then
            cls()
            loaded_black = true
            draw_rle(drag_black,0,0)
            pelogen_tri_low(113, 110, 123, 100, 113, 90, 5)
            print("black", 8, 8, 5)
        end
    elseif scene == "red_drag" then
        if not loaded_red then
            cls()
            loaded_red = true
            draw_rle(drag_red,0,0)
            pelogen_tri_low(14, 110, 4, 100, 14, 90, 8)
            print("red", 8, 8, 8) 
          end
    end
end

function init_char_select()
    loaded_blue = false
    loaded_red = false
    loaded_black = false
    loaded_main = false
    drag_scenes = {"blue_drag", "black_drag", "red_drag"}
end
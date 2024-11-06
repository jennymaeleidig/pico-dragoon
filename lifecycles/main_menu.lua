function update_main_menu()
    if scene == "main_menu" then
        if btnp(5) then
            scene = "blue_drag"
            loaded_main = false
        end
    end
end

function draw_main_menu()
    if scene == "main_menu" then
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
end
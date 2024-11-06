function update_stage()
    if in_stage then
        if scene == "stage1" then
            update_stage_1()
        end
            update_ui()
            plr.update(plr)
            update_projs()
    end
end

function draw_stage()
    if in_stage then
        if scene == "stage1" then
            draw_stage_1()
        end
            draw_projs()
            draw_ui()
            plr.draw(plr)
    end
end

function init_stage()
    init_proj()
    init_ui()
    gnd_ptn_fwd = {{{1,3},{10,17},{28,47},{64,64}},
        {{3,5},{13,20},{38,60},{64,64}},
        {{0,0},{4,8},{17,26},{48,60}},
        {{0,2},{6,12},{20,37},{64,64}}}
    gnd_ptn_fwd_i = 1
    in_stage = false
    horizon = 67
end
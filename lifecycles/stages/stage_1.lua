function update_stage_1()
    if (frame % 6 == 0) then
        gnd_ptn_fwd_i = ((gnd_ptn_fwd_i == 4) and 1 or (gnd_ptn_fwd_i + 1))
    end
end

function draw_stage_1()
    cls()  
    
    -- Default stage 1 pallete
    pal({[0]=7,12,1,140,0,9},1)

    -- Stage one Pallete blue dragon
    pal({[0]=7,12,1,140,0,9,129,6,5},1)
    --new colors, maybe only set once 
    draw_rle(stg_1_bg,0,0)

    rectfill(0, horizon, 127, 127, 2)
    -- need to reset pallete based on stage
    for i = 1, count(gnd_ptn_fwd[gnd_ptn_fwd_i]) do
    rectfill(0, horizon+gnd_ptn_fwd[gnd_ptn_fwd_i][i][1], 127, horizon+gnd_ptn_fwd[gnd_ptn_fwd_i][i][2], 3)
    end
end
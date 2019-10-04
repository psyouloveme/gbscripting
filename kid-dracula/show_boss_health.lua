



while true do
    local WRAMOffset = 0xC005
    for i = 0, 15 do
        local val = memory.readbyte(WRAMOffset + (256 * i))
        if (val > 0) then
            gui.drawText(5, i * 5, i.." "..val, "red", 0x00000000, 10, nil, nil, "left", "top")
        end
    end

    local offset1 = 0xC805
    local offset2 = 0xC605
    local offset3 = 0xC905
    local offset4 = 0xCB05
    local v1 = memory.readbyte(offset1)
    local v2 = memory.readbyte(offset2)
    local v3 = memory.readbyte(offset3)
    local v4 = memory.readbyte(offset4)


    if (v1 > 0) then
        gui.drawText(15, 15, "v1: "..v1, "red", 0x00000000, 12, nil, nil, "left", "top")
    end
    if (v2 > 0) then
        gui.drawText(15, 30, "v2: "..v2, "red", 0x00000000, 12, nil, nil, "left", "top")
    end
    if (v3 > 0) then
        gui.drawText(15, 45, "v3: "..v3, "red", 0x00000000, 12, nil, nil, "left", "top")
    end
    if (v4 > 0) then
        gui.drawText(15, 60, "v4: "..v4, "red", 0x00000000, 12, nil, nil, "left", "top")
    end
    emu.frameadvance()
end

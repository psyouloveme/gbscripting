local OAMOffset = 0xFE00

function drawSpriteLocation(x, y, spriteNumber, color)
    if (x > 0 and y > 0 and x < 168 and y < 160) then
        if (spriteNumber < 10) then
            spriteNumber = "0"..spriteNumber
        end
        gui.drawText(x - 10, y - 16, spriteNumber, "red", 0x00000000, 8, nil, nil, "left", "top")
        -- gui.drawPixel(spriteX, spriteY, "blue")
        gui.drawRectangle(x - 8, y - 16, 7, 15, 0x550000FF, 0x550000FF)
    end
end

function getOAMAttrs(slot) 
    if (slot < 40 and slot >= 0) then
        local spriteOffset = OAMOffset + (slot * 4)
        local spriteY = memory.readbyte(spriteOffset)
        local spriteX = memory.readbyte(spriteOffset + 1)
        local spriteTile = memory.readbyte(spriteOffset + 2)
        local spriteFlags = memory.readbyte(spriteOffset + 3)
        return spriteY, spriteX, spriteTile, spriteFlags
    end
end

function drawOAMSprites()
    local color = 0x550000FF
    for i = 0, 39 do
        local y, x, tile, flags = getOAMAttrs(i)
        drawSpriteLocation(x, y, i, color)
    end
end

while true do
    drawOAMSprites()
    emu.frameadvance()
end

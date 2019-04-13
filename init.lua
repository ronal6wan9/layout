require 'strict'

function rgb(r, g, b) return ((r * 256) + g) * 256 + b end

-- helper function to display a region as a rect
function showRegion(id, fill, layout, parent)
    local rect = layout:regionRect(id)

    -- NOTE: Corona to Gideros
    -- Regions:insert( rect )
    -- rect.fill = fill or { 0, 0 }
    -- rect.stroke = { 1, 1 }
    -- rect.strokeWidth = Layout.pixel
    parent:addChild(rect)
    fill = fill or {0, 0}
    if #fill == 3 then fill = {rgb(fill[1], fill[2], fill[3])} end
    rect:setFillColor(unpack(fill))
    rect:setLineColor(0xffffff)
    rect:setLineThickness(1)

    local region = layout[id]

    -- NOTE: Corona to Gideros
    -- local text = display.newText( id, region.xCenter, region.yCenter, native.systemFont, 20 * Layout.pixel )
    -- Regions:insert( text )
    -- text.fill = { 1, 1 }
    local text = TextField.new(
        nil,
        id,
        id,
        {
            w = region.width,
            h = region.height,
            flags = FontBase.TLF_CENTER | FontBase.TLF_VCENTER
        }
    )
    parent:addChild(text)
    text:setPosition(region.left, region.top)
    text:setTextColor(0xffffff)
end

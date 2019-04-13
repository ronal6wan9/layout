-- ========================================================================== --
-- example-04.lua
--
-- Expands on example-04 by slightly shrinking all of the "cell" regions after
-- they are created by a fixed number of pixels per dimension, demonstrating the
-- use of adjustRegion and showing how the Layout.pixel element might be used.
-- layout.lua is in parent folder
-- NOTE: Corona to Gideros
-- package.path = "../?.lua;" .. package.path
-- local LayoutManager = require( "layout" )
-- layout manager object
local Layout

-- Group to hold rects that display the regions
local Regions

-- Content grid size; change these to change the size of the generated grid
local ContentGridSize = 4
local GridPixelPadding = 8

-- layout creation
local function createLayout()
    -- init the layout manager
    -- NOTE: Corona to Gideros
    -- Layout = LayoutManager:new()
    Layout = LayoutManager.new()

    -- device is in portrait orientation
    if (Layout.stage.isPortrait) then
        -- create a header occupying 10% of the stage
        Layout:addRegion({id = "header", vertical = "top", height = 10})
        -- create a content area below the header with some small padding
        Layout:addRegion({
            id = "content",
            positionTo = "header",
            vertical = "below",
            height = 83,
            padding = {top = 1}
        })
        -- create a footer area at the bottom of the stage
        Layout:addRegion({id = "footer", vertical = "bottom", height = 5})
        -- device is in landscape orientation
    else
        -- create a header occupying 10% of the stage
        Layout:addRegion({id = "header", horizontal = "left", width = 10})
        -- create a content area below the header with some small padding
        Layout:addRegion({
            id = "content",
            positionTo = "header",
            horizontal = "after",
            width = 83,
            padding = {left = 1}
        })
        -- create a footer area at the bottom of the stage
        Layout:addRegion({id = "footer", horizontal = "right", width = 5})
    end
    -- Create the content grid regions. This works independent of device
    -- orientation since we are working relative to the "content" region
    -- already created above.
    local cellWidth = 100 / ContentGridSize
    local cellHeight = 100 / ContentGridSize
    for row = 1, ContentGridSize do
        for col = 1, ContentGridSize do
            local id = "(" .. row .. "," .. col .. ")"
            local dimens = {
                id = id,
                sizeTo = "content",
                width = cellWidth,
                height = cellHeight,
                horizontal = "left",
                vertical = "top",
                padding = {left = cellWidth * (col - 1), top = cellHeight * (row - 1)}
            }
            Layout:addRegion(dimens)
            dimens = {
                id = id,
                width = Layout[id].width - GridPixelPadding * Layout.pixel,
                height = Layout[id].height - GridPixelPadding * Layout.pixel
            }
            Layout:adjustRegion(dimens)
        end
    end
end

-- ========================================================================== --

-- for demo purposes just display the layout regions as rects on the screen
local function showLayout()
    -- NOTE: Corona to Gideros
    -- Regions = display.newGroup()
    Regions = Sprite.new()
    stage:addChild(Regions)

    -- NOTE: Corona to Gideros
    -- showRegion( "header", {0.5,0,0} )
    -- showRegion( "content", {1,0.5} )
    -- showRegion( "footer", {0,0,0.5} )
    showRegion("header", {0.5, 0, 0}, Layout, Regions)
    showRegion("content", {1, 0.5}, Layout, Regions)
    showRegion("footer", {0, 0, 0.5}, Layout, Regions)

    for row = 1, ContentGridSize do
        for col = 1, ContentGridSize do
            -- showRegion( "("..row..","..col..")" )
            showRegion("(" .. row .. "," .. col .. ")", nil, Layout, Regions)
        end
    end
end

-- ========================================================================== --

-- orientation change listener
local function onOrientationChange(event)
    -- NOTE: Corona to Gideros
    -- Regions:removeSelf()
    Regions:removeFromParent()

    Regions = nil
    createLayout()
    showLayout()
end

-- add listener for orientation change
-- NOTE: Corona to Gideros
-- Runtime:addEventListener( "orientation", onOrientationChange )
stage:addEventListener(Event.APPLICATION_RESIZE, onOrientationChange)

-- ========================================================================== --

-- initial layout and display
createLayout()
showLayout()

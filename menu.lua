
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- This is a good place to put variables and functions that need to be available scene
-- wide.
-- -----------------------------------------------------------------------------------

local function gotoGame()
	composer.removeScene( "category" )
    composer.gotoScene( "category", { time=400, effect="crossFade" } )
end

local function quit()
	composer.gotoScene( "quit" )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local background = display.newImageRect( sceneGroup, "menu_bg_hd.jpg", 652, 1217 )
    background:scale(.50,.50)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

   -- local title = display.newImageRect( sceneGroup, "title.png", 262, 66 )
    --title.x = display.contentCenterX
    --title.y = display.contentCenterY-150

    local playButton = display.newImageRect( sceneGroup, "play_bt_26.png", 315, 99 )
    playButton:scale(.5,.5)
    playButton.x = display.contentCenterX
    playButton.y = display.contentCenterY+25

    --local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 700, native.systemFont, 44 )
    --playButton:setFillColor( 0.82, 0.86, 1 )

    local quit = display.newImageRect( sceneGroup, "quit_bt_26.png", 315, 99 )
    quit:scale(.5,.5)
    quit.x = display.contentCenterX
    quit.y = display.contentCenterY+80


  --  local Quit = display.newText( sceneGroup, "High Scores", display.contentCenterX, 810, native.systemFont, 44 )
   -- highScoresButton:setFillColor( 0.75, 0.78, 1 )

    playButton:addEventListener( "tap", gotoGame )
    quit:addEventListener( "tap", quit )

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
 
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

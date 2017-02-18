local composer = require( "composer" )
local gameState= require("gamestate")

local scene = composer.newScene()
local widget = require( "widget" )
local ok=false
local cancel =false
local bg_name
function  scene:create(event)
	local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent

if(gameState.dialogbox=="quit")then
bg_name="quit_box_glow.png"
elseif(gameState.dialogbox=="reload")then
bg_name="restart_box.png"
end
local background = display.newImage( sceneGroup,bg_name)
background:scale( 0.75, 0.75 )
background.x=display.contentCenterX
background.y=display.contentCenterY+50


local  offset_y = background.y+60

local quit_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "tick.png",
        overFile = "tick.png",
        --label = "bt_reload",
        onEvent = function ( )
          ok=true
          composer.hideOverlay( "fade", 400 )   

        end
    }
)

quit_bt.x = display.contentCenterX-40
quit_bt.y = offset_y
  sceneGroup:insert(quit_bt)


  local play_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "x_but.png",
        overFile = "x_but.png",
        --label = "bt_reload",
        onEvent = function ( )
        	cancel=true
          composer.hideOverlay( "fade", 400 )


        end
    }
)

play_bt.x = display.contentCenterX+40
play_bt.y = offset_y
  sceneGroup:insert(play_bt)
	
end


function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
       -- parent:resumeGame()
       if(ok==true)then
        if(gameState.dialogbox=="quit")then
          parent:quit_overlay()
          elseif(gameState.dialogbox=="reload")then
            parent:reload_overlay()
          ok = false
       end
       elseif(cancel==true)then
          parent:ok_overlay()
          cancel = false
       end
          -- 

    end
end

-- By some method (a "resume" button, for example), hide the overlay

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
return scene
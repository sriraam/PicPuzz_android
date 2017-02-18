local composer = require( "composer" )

local scene = composer.newScene()
local widget = require( "widget" )
local reload=false
local play =false
function  scene:create(event)
	local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent


local background = display.newImage( sceneGroup,"completed.png")
background:scale( 0.5, 0.5 )
background.x=display.contentCenterX
background.y=display.contentCenterY

local reload_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "reload.png",
        overFile = "reload.png",
        --label = "bt_reload",
        onEvent = function ( )
          reload=true
          composer.hideOverlay( "fade", 400 )   

        end
    }
)

reload_bt.x = display.contentCenterX
reload_bt.y = display.contentCenterY+100
  sceneGroup:insert(reload_bt)


  local play_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "play.png",
        overFile = "play.png",
        --label = "bt_reload",
        onEvent = function ( )
        	play=true
          composer.hideOverlay( "fade", 400 )


        end
    }
)

play_bt.x = display.contentCenterX-70
play_bt.y = display.contentCenterY+100
  sceneGroup:insert(play_bt)
	
end


function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
       -- parent:resumeGame()
       if(reload==true)then
          parent:reload_overlay()
          reload = false
       end
       if(play==true)then
          parent:ok_overlay()
          play = false
       end
          -- 

    end
end

-- By some method (a "resume" button, for example), hide the overlay

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
return scene
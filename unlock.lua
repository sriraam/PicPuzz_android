local composer = require( "composer" )
local gameState = require("gamestate")

local scene = composer.newScene()
local widget = require( "widget" )
local unlock=false
local menu =false


function  scene:create(event)
	local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent


local background = display.newImage( sceneGroup,"unlock_dialog_box.png")
background:scale( 0.75, 0.75)
background.x=display.contentCenterX
background.y=display.contentCenterY



local unlock_bt = widget.newButton(
    {
        width = 91,
        height = 93,
        defaultFile = "20_star_but.png",
        --overFile = "ok_bt.png",
        --label = "bt_reload",
        onEvent = function ( )
          unlock=true
         --gameState.stars=
          composer.hideOverlay( "fade", 400 )   

        end
    }
)

unlock_bt.x = display.contentCenterX
unlock_bt.y = display.contentCenterY+50
  sceneGroup:insert(unlock_bt)


local close =widget.newButton(
    {
        width = 44,
        height = 45,
        defaultFile = "x_bt.png",
        --overFile = "x_icon.png",
        --label = "bt_reload",
        onEvent = function ( )
          unlock=false
          composer.hideOverlay( "fade", 400 )   

        end

  }

    )

close.x=display.contentCenterX+120
close.y=display.contentCenterY-60
sceneGroup:insert(close)

  end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
       -- parent:resumeGame()
       if(unlock==true)then
        print("called unlock_overlay")
        --  parent:reload_overlay()
         parent:unlock_overlay()

          unlock = false
        else


       end
       --[[
       if(menu==true)then
       	 composer.removeScene( "category")
          composer.gotoScene( "category")
         -- parent:ok_overlay()
          menu = false
       end--]]
    end
end

-- By some method (a "resume" button, for example), hide the overlay

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
return scene
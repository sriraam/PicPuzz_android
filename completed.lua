local composer = require( "composer" )
local gameState = require("gamestate")

local scene = composer.newScene()
local widget = require( "widget" )
local reload=false
local menu =false
local next=false
local stars =gameState.stars
local star_dis
local secondsLeft=gameState.time

function  scene:create(event)
	local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent


local background = display.newImage( sceneGroup,"completion_panel.png")
background:scale( 0.55, 0.55 )
background.x=display.contentCenterX
background.y=display.contentCenterY+20

local xpos={background.x-60,background.x,background.x+60}
local ypos = {background.y-25,background.y-45,background.y-25}


for i=1,3 do
	--n=star+1
if(i<=stars)then	
star_dis = display.newImage( sceneGroup,"star"..i..".png")
else
 star_dis = display.newImage( sceneGroup,"stari"..i..".png")
end
star_dis:scale( .75,.75)
star_dis.x=xpos[i]
star_dis.y=ypos[i]

	end
offset_y=background.y+140

---------------------------------------------------------------------------------------------------
--Displaying time taken
--------------------------------------------------------------------------------------------------
  local minutes = math.floor( secondsLeft / 60 )
  local seconds = secondsLeft % 60
  
  -- make it a string using string format.  
  local timeDisplay = string.format( "%02d:%02d", minutes, seconds )


local time_text=display.newText( sceneGroup,"Time - "..timeDisplay, background.x+6, background.y+49 , "CarterOne",32 )
time_text:setFillColor( 0,0,0,1)


display.newText( sceneGroup,"Time - "..timeDisplay, background.x+5, background.y+50 , "CarterOne",30 )


local reload_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "reload_bt_org.png",
        overFile = "reload_bt_org.png",
        --label = "bt_reload",
        onEvent = function ( )
          reload=true
          composer.hideOverlay( "fade", 400 )   

        end
    }
)

reload_bt.x = display.contentCenterX
reload_bt.y = offset_y
  sceneGroup:insert(reload_bt)


  local menu_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "menu_bt_org.png",
        overFile = "menu_bt_org.png",
        --label = "bt_reload",
        onEvent = function ( )
        	menu=true
          composer.hideOverlay( "fade", 400 )


        end
    }
)

menu_bt.x = display.contentCenterX-70
menu_bt.y = offset_y
  sceneGroup:insert(menu_bt)
	


  local next_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "forward_bt_org.png",
        overFile = "forward_bt_org.png",
        --label = "bt_reload",
        onEvent = function ( )
        	next=true
          composer.hideOverlay( "fade", 400 )


        end
    }
)

next_bt.x = display.contentCenterX+70
next_bt.y = offset_y
  sceneGroup:insert(next_bt)
	
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
       if(menu==true)then
       	 composer.removeScene( "category")
          composer.gotoScene( "category")
         -- parent:ok_overlay()
          menu = false
       end
       if(next==true)then
          next=false
          composer.removeScene( "levels")
          composer.gotoScene( "levels")
        end
    end
end

-- By some method (a "resume" button, for example), hide the overlay

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
return scene
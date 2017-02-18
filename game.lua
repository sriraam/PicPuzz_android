
local composer = require( "composer" )
local gameState = require("gamestate")
local progressRing = require("progressRing")

local xpos_lim={display.contentCenterX-100,display.contentCenterX,display.contentCenterX+100}
local ypos_lim={display.contentCenterY-33,display.contentCenterY+67,display.contentCenterY+167}
local save_once=false
local widget = require( "widget" )

local fact_table={}
local json = require( "json" )

local timetable = {}

local filePath_stars = system.pathForFile( "pp_rewards.json", system.DocumentsDirectory )

local filePath_scores = system.pathForFile( "pp_times.json", system.DocumentsDirectory )

local filePath_levels = system.pathForFile( "pp_levelss.json", system.DocumentsDirectory )

local level_table={}
local continue=false

--local usedseconds
local fini_triggered=true
local show_img
local clockText
local countDownTimer
local  puztime=true
local objectSheet
local freepos=9
local j=0
local clickpos
local clickpos_x=0
local clickpos_y=0
local randarr={1}
local imgpos={}
local rand
local quit
local ring

local sec_over=false
local secondsLeft  -- 20 minutes * 60 seconds
local init_secondsleft

local mainGroup 

local imgdisplay ={}



local sheetOptions =
{
    frames =
    {
        {   -- 1) asteroid 1
            x = 0,
            y = 0,
            width = 100,
            height = 100
        },
        {   -- 2) asteroid 2
            x = 100,
            y = 0,
            width = 100,
            height = 100
        },
        {   -- 3) asteroid 3
            x = 200,
            y = 0,
            width = 100,
            height = 100
        },
        {   -- 4) ship
            x = 0,
            y = 100,
            width = 100,
            height = 100
        },
        {   -- 5) laser
            x = 100,
            y = 100,
            width = 100,
            height = 100
        },
        {   -- 6) laser
            x = 200,
            y = 100,
            width = 100,
            height = 100
        },
        {   -- 7) laser
            x = 0,
            y = 200,
            width = 100,
            height = 100
        },
        {   -- 8) laser
            x = 100,
            y = 200,
            width = 100,
            height = 100
        },
    }
}


--this below var gives the selected category and level which is used to import the pic from its name (puzz24.jpg)
local category=gameState.category
local level=gameState.level


   objectSheet = graphics.newImageSheet( "puzz"..category..level..".jpg", sheetOptions )



local xpos ={display.contentCenterX-100,display.contentCenterX,display.contentCenterX+100,display.contentCenterX-100,display.contentCenterX,display.contentCenterX+100,display.contentCenterX-100,display.contentCenterX,display.contentCenterX+100}

local ypos ={display.contentCenterY-33,display.contentCenterY-33,display.contentCenterY-33,display.contentCenterY+67,display.contentCenterY+67,display.contentCenterY+67,display.contentCenterY+167,display.contentCenterY+167,display.contentCenterY+167}



local params = {
  radius = 50,
  ringColor = {0, 0, 0, 1},
  bgColor = {1,1,1, 1},
  ringDepth = 1,
  position=0,
  counterclockwise = false,
  strokeWidth = 10,
  strokeColor = {1, 1, 1, 1},
  time = 610000,
}

local ring = progressRing.new(params)
ring:goTo(1)
ring.x=display.contentCenterX+75
ring.y=display.contentCenterY-159



local function onComplete(event)
if ring.position == 1 then
ring:goTo(0)
elseif ring.position == 0 then
ring:goTo(1)
end
end





--from json file it loads the time taken for finishing the levels
local function loadtime()

    local file = io.open( filePath_scores, "r" )

    if file then
        local contents = file:read( "*a" )
        io.close( file )
        timetable = json.decode( contents )
    end

    if ( timetable == nil or #timetable == 0 ) then
--first pos hold the remaining seconds for the whole categoty
        timetable =  {{ 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
                    }
    

    end

   -- secondsLeft=timetable[category][1]+timetable[category][level+1] 
    --while seconds changes continously a temp var is created to calculate the level timetaken
    secondsLeft=600
    init_secondsleft=secondsLeft
end

local function loadrewards()
  local file = io.open( filePath_stars, "r" )

    if file then
        local contents = file:read( "*a" )
        io.close( file )
        reward_table = json.decode( contents )
    end

    if ( reward_table == nil or #reward_table == 0 ) then
--first pos hold the remaining seconds for the whole categoty
        reward_table ={{0,0},
                       {1,1,1,1},  
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
                    }
    

    end
end


local function savetime()

local stars 
    local file1 = io.open( filePath_scores, "w" )
    local  file2 = io.open(filePath_stars,"w") 
--timetable[category][1]=secondsLeft
--the seconds taken to finish the level is noted in its respective position in table
if(secondsLeft>=420)then
stars=3
elseif(secondsLeft>=240)then
stars=2
else
  stars=1
end
--print( "reward_table"..reward_table[category][gameState.level] )
--[[
print( "game"..reward_table[1][1] )
if(save_once==false)then
save_once=true
print( save_once )
reward_table[1][1]=reward_table[1][1]+stars

end--]]
reward_table[category+2][gameState.level]=stars
gameState.stars=stars

--print( "stars is"..stars )
timetable[category][gameState.level]=init_secondsleft-secondsLeft
    if file1 then
        file1:write( json.encode( timetable ) )
        io.close( file1 )
    end
    if file2 then
   --[[for reseting//  
    reward_table ={ {0,0},
                        {1,1,1,1},

                     { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
                    }
                    --]]
        file2:write( json.encode( reward_table ) )
        io.close( file2 )
    end
end


local function loadlevels()

    local file = io.open( filePath_levels, "r" )

    if file then
        local contents = file:read( "*a" )
              
        io.close( file )
        level_table = json.decode( contents )
      
    end

end

local function savelevel()


    local file = io.open( filePath_levels, "w" )
    
level_table[category][level+1]=1
--print(level+1)
    if file then
        file:write( json.encode( level_table ) )
        io.close( file )
    end
  --  print( "contents" )
    for i=1,9 do
 --  print(level_table[category][i] )
end
end

local function updateTime()
  -- decrement the number of seconds
 --   print( "entered updateTime" )

 -- print( puztime )
  if(puztime==true)then

  secondsLeft = secondsLeft - 1
  --print( "seconds"..secondsLeft )
  -- time is tracked in seconds.  We need to convert it to minutes and seconds
  local minutes = math.floor( secondsLeft / 60 )
  local seconds = secondsLeft % 60
  
  -- make it a string using string format.  
 -- local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
  --clockText.text = timeDisplay

  end
end

function movetile()


         -- local temp=freepos
          transition.to( imgdisplay[imgpos[clickpos]],{x=xpos[freepos],y=ypos[freepos],time=1} )

local temp1=imgpos[clickpos]
          imgpos[clickpos]=0
          imgpos[freepos]=temp1
 

        -- imgdisplay[imgpos[clickpos]]
         -- ship.x=xpos[freepos]
          --ship.y=ypos[freepos]
          freepos=clickpos
          clickpos=0
          print("freepos "..freepos)


end
function move2tile_up()
         
          transition.to( imgdisplay[imgpos[clickpos]],{x=xpos[clickpos-3],y=ypos[clickpos-3],time=1} )
          transition.to( imgdisplay[imgpos[clickpos-3]],{x=xpos[freepos],y=ypos[freepos],time=1} )
          local temp1=imgpos[clickpos-3]
         -- local temp2 =imgpos[clickpos+1]
            imgpos[clickpos-3]=imgpos[clickpos]
            imgpos[clickpos-6]=temp1
            imgpos[clickpos]=0
          freepos=clickpos
          clickpos=0
          
end

function move2tile_down()
         
          transition.to( imgdisplay[imgpos[clickpos]],{x=xpos[clickpos+3],y=ypos[clickpos+3],time=1} )
          transition.to( imgdisplay[imgpos[clickpos+3]],{x=xpos[freepos],y=ypos[freepos],time=1} )
          local temp1=imgpos[clickpos+3]
         -- local temp2 =imgpos[clickpos+1]
            imgpos[clickpos+3]=imgpos[clickpos]
            imgpos[clickpos+6]=temp1
            imgpos[clickpos]=0
          freepos=clickpos
          clickpos=0
          
end
function move2tile_left()
	
          transition.to( imgdisplay[imgpos[clickpos]],{x=xpos[freepos+1],y=ypos[freepos+1],time=1} )
          transition.to( imgdisplay[imgpos[clickpos-1]],{x=xpos[freepos],y=ypos[freepos],time=1} )

          local temp1=imgpos[clickpos-1]
         -- local temp2 =imgpos[clickpos+1]
          imgpos[clickpos-1]=imgpos[clickpos]
          imgpos[clickpos-2]=temp1
          imgpos[clickpos]=0
          freepos=clickpos
          clickpos=0
         print("freepos "..freepos)
         print( imgpos[clickpos+1] )  
        
end
function move2tileright()
	
          transition.to( imgdisplay[imgpos[clickpos]],{x=xpos[freepos-1],y=ypos[freepos-1],time=1} )
          transition.to( imgdisplay[imgpos[clickpos+1]],{x=xpos[freepos],y=ypos[freepos],time=1} )

          local temp1=imgpos[clickpos+1]
         -- local temp2 =imgpos[clickpos+1]
          imgpos[clickpos+1]=imgpos[clickpos]
          imgpos[clickpos+2]=temp1
          imgpos[clickpos]=0
          freepos=clickpos
          clickpos=0
         print("freepos "..freepos)
         print( imgpos[clickpos+1] )  
        
end


local function dragShip( event )

    local ship = event.target
    --local phase = event.phase

    if ( event.phase == "began") then
        -- Set touch focus on the ship
        local i=1
        display.currentStage:setFocus( ship )

        --gets the touched tile x,y pos
        local click_tile_posx=ship.x
        local click_tile_posy=ship.y
        

        --check the tiles x & y pos in 1,2,3
        for i=1,3 do
        	if(click_tile_posx==xpos_lim[i]) then
               clickpos_x=i
                print( "cliclx"..clickpos_x )

           end
           if(click_tile_posy==ypos_lim[i]) then
               clickpos_y=i
               print( "clicly"..clickpos_y )
           end
       end
       --converting 1,2,3(x) and 1,2,3(y) parts into actual 1 to 9 number
       clickpos=(3*clickpos_y)-(3-clickpos_x)
       --clickpos = clickpos - (3-cliclkpos_y)
print( "clickpos"..clickpos )




        ship.touchOffsetX = event.x - ship.x
        ship.touchOffsetY = event.y - ship.y


    elseif ( event.phase == "moved" ) then

    -- Move the ship to the new touch position
      --if freetile in desired pos then checks the possible move with the dragged one
      --then the freepos will be the dragedpos and viceversa and atlast assignes clickpos =0 and get readys for next touch 
        if(freepos==9 and (clickpos==8 or clickpos==6))then
       
        	movetile()

end

if(freepos==9 and (clickpos==7 or clickpos==3))then

         

         if(clickpos==7)then

          move2tileright()
        
        elseif(clickpos==3)then
       move2tile_down()
        end
    end
        if(freepos==8 and (clickpos==9 or clickpos==7 or clickpos==5 ))then
      movetile()
  elseif(freepos==8 and (clickpos==2))then
          move2tile_down()

        end
        if(freepos==5 and (clickpos==2 or clickpos==8 or clickpos==4 or clickpos==6 ))then
       movetile()  
        end
        if(freepos==6 and (clickpos==3 or clickpos==9 or clickpos==5 ))then
           movetile()
           elseif(freepos==6 and clickpos==4)then
 	          move2tileright()
        end
        if(freepos==7 and (clickpos==4 or clickpos==8))then
           movetile()
           elseif(freepos==7 and clickpos==1)then
	         move2tile_down()
           elseif(freepos==7 and clickpos==9)then
	         move2tile_left()
        end
        if(freepos==4 and (clickpos==1 or clickpos==7 or clickpos==5 ))then
          movetile()
          elseif(freepos==4 and clickpos==6)then
	        move2tile_left()
        end
        if(freepos==3 and (clickpos==2 or clickpos==6))then
           movetile()
          elseif(freepos==3 and clickpos==9)then
          	move2tile_up()
          elseif(freepos==3 and clickpos==1)then
            move2tileright()	
        end
        if(freepos==2 and (clickpos==5 or clickpos==1 or clickpos==3 ))then
          movetile()
            elseif(freepos==2 and clickpos==8)then
            	move2tile_up()
        end
        if(freepos==1 and (clickpos==4 or clickpos==2))then
          movetile()
          elseif(freepos==1 and clickpos==3)then
          	move2tile_left()
          elseif(freepos==1 and clickpos==7)then
          	move2tile_up()
        end

    elseif ( event.phase == "ended" or event.phase ==  "cancelled" ) then
       
        display.currentStage:setFocus( nil )
    end

    return true  -- Prevents touch propagation to underlying objects
end


function tile_creation()
	for i = 1, 8 do
    imgdisplay[i]=display.newImageRect( mainGroup, objectSheet, i, 100, 100)
        imgdisplay[i].myName = "tile"
    imgdisplay[i]:addEventListener( "touch", dragShip )

end
end

function shuffle_tile()
	local i =1
  randarr={1}
	--random number should genrate non repeated values from 2 to 8
	while(i~=8) do
 --randgen()
     rand=math.random(2, 8)

if(table.indexOf( randarr, rand )==nil) then
	table.insert( randarr, rand )
     imgdisplay[rand].x = xpos[i]

     imgdisplay[rand].y = ypos[i]
     table.insert( imgpos, i, rand)

     i=i+1
  end
 -- randarr={1}
end
--to avoid the easy random generation we are placind the first tile to last positiom

     table.insert( imgpos, 8, 1)

     table.insert( imgpos, 9, 0)
     print( "imagepos is"..imgpos[9] )

imgdisplay[1].x = xpos[8]

imgdisplay[1].y = ypos[8]
--imgdisplay[1].myName="tile"
print( imgdisplay[i].x )
freepos=9

end

local function gotoMenu()
           -- print("Entered endGame....but what happened")
           print("entered endGame")
           --stops the timer
        puztime=false
        composer.gotoScene( "menu")

end


local options = {
    isModal = true,
    effect = "zoomOutIn",
    time = 0,
   -- params = {
     --   sampleVar = "my sample variable"
    --}
}

local options2 = {
    isModal = true,
    effect = "zoomOutIn",
    time = 300,
   -- params = {
     --   sampleVar = "my sample variable"
    --}
}


local function Update()


--print( "Entered updateloop" )
local j=0
   for i = 1, 8 do
if(imgdisplay[i].x==xpos[i] and imgdisplay[i].y==ypos[i])then
	 j=j+1
end
end
if(secondsLeft==1)then
 -- print( "second is at pause" )
  puztime=false
  timer.cancel( countDownTimer )
  sec_over=true
  composer.showOverlay("timeover_box",options)
  gameState.dialogbox="timeover_box"
 -- display dialog box reg timeout...

end

if(j==8)then
  -- print( "You won" )
 
   -- timer.pause(countDownTimer)
   
 -- local  function completed( )
     puztime=false
  -- end
  ring:pause()

  savetime()
  savelevel()
  gameState.time=600-secondsLeft
     composer.showOverlay( "completed", options )

 -- livesText = display.newText(textgroup,"Great YOU HAVE FINISHED THE PUZZ ", 200, 80, native.systemFont, 36 )
  --composer.gotoScene("levels")
  
 end
end




local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

function scene:quit_overlay()
  print(" quit executed" )
composer.removeScene("levels")
  composer.gotoScene("levels")

end

local  ringGroup 
function scene:reload_overlay()
--  print(" Reload executed" )
print("Entered reload overlay")

 secondsLeft=init_secondsleft
  puztime=true
  print(secondsLeft)

  timer.resume( countDownTimer )
  shuffle_tile()
  j=0
ring:reset()

--secondary ring_hich will be executed in reload
ring = progressRing.new(params)
ringGroup:insert(ring)
ring:goTo(1)
ring.x=display.contentCenterX+75
ring.y=display.contentCenterY-159

   --timer.resume( countDownTimer )

if(sec_over==true)then
 countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
 sec_over=false
 end

end

function showpic()
composer.showOverlay( "pic_zoom",options2)

end


--it will executed from overlay command,if completed then saves data in jason
--else if it is other than level cleaed overlay,it will reamain as ok button 
--and continues without changing the time
function scene:ok_overlay()
 -- print(" play executed" )
   -- shuffle_tile()
puztime=true
    timer.resume( countDownTimer )
     ring:resume()  
  end
--end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view

  loadlevels()
  loadrewards()
	-- Code here runs when the scene is first created but has not yet appeared on screen
  backgroup=display.newGroup()
  sceneGroup:insert(backgroup)
--print( "cur_level"..level   )

 ringGroup=display.newGroup()
 sceneGroup:insert( ring )
sceneGroup:insert( ringGroup )

--ring:addEventListener("completed", onComplete)

     local box = display.newImageRect(sceneGroup,"black_frame.png",310,310)
   --bottom:scale( .5, .5 )
   box.x = display.contentCenterX
  box.y = display.contentCenterY+67

local black_box = display.newImageRect(sceneGroup,"black_tile.png",305,305)
   --bottom:scale( .5, .5 )
  black_box.x = display.contentCenterX
  black_box.y = display.contentCenterY+66



  mainGroup = display.newGroup()
sceneGroup:insert(mainGroup)

  uigroup=display.newGroup()

   -- clockText = display.newText("Time Rem",display.contentCenterX+75, display.contentCenterY-125, native.systemFontBold, 35)


--clockText:setFillColor( 0, 0, 0 )

 --sceneGroup:insert(clockText)

 textgroup=display.newGroup()

  sceneGroup:insert(textgroup)


  local backgr = display.newImageRect(backgroup,"black_bg_light2.jpg", 800,1400 )
  backgr:scale( .45, .45 )
  backgr.x = display.contentCenterX
  backgr.y = display.contentCenterY-15


local show_img_bg =display.newImageRect(mainGroup,"black_frame.png",120,120)
 show_img_bg.x=display.contentCenterX-75
  show_img_bg.y=display.contentCenterY-160

  local show_img_effect =display.newImageRect(mainGroup,"white_effect.png",110,110)
 show_img_effect.x=display.contentCenterX-75
  show_img_effect.y=display.contentCenterY-160

     show_img = display.newImageRect(mainGroup,"puzz"..category..level..".jpg", 100, 100 )
     show_img:addEventListener( "tap",showpic )
  show_img.x=display.contentCenterX-75
  show_img.y=display.contentCenterY-160


  local twist_ui = display.newImage( sceneGroup, "game_ui_twist.png",display.contentCenterX+90, display.contentCenterY-250 )
twist_ui:scale( .50, .50 )

    local reload_bt = widget.newButton(
    {
        width = 45,
        height = 45,
        defaultFile = "reload_bt_org.png",
        overFile = "reload_bt_org.png",
        --label = "bt_reload",
        onEvent = function ( )
          puztime=false
          timer.cancel( countDownTimer )
          sec_over=true
          gameState.dialogbox="reload"
          ring:pause()
          composer.showOverlay("quit",options)
   -- secondsLeft=init_secondsleft+timetable[category][level+1]
   -- composer.gotoScene( "game")
   -- shuffle_tile()

        end
    }
)

reload_bt.x = display.contentCenterX-123
reload_bt.y = display.contentCenterY-250
  sceneGroup:insert(reload_bt)

--[[
 local pause_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "pause.png",
        overFile = "pause.png",
        --label = "bt_reload",
        onEvent = function()
            

            timer.pause(countDownTimer)
            for i=1,8 do
              imgdisplay[i]:removeEventListener( "touch", dragShip )

composer.showOverlay( "completed", options )
            end
        

      end
    }
)

pause_bt.x = display.contentCenterX+75
pause_bt.y = display.contentCenterY-200
  sceneGroup:insert(pause_bt)


 local play_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "play.png",
        overFile = "play.png",
        --label = "bt_reload",
        onEvent = function()

          for i=1,8 do
     imgdisplay[i]:addEventListener( "touch", dragShip )

end
            timer.resume(countDownTimer)
        

      end
    }
)

play_bt.x = display.contentCenterX
play_bt.y = display.contentCenterY-200
  sceneGroup:insert(play_bt)
--]]

local menu_bt = widget.newButton(
    {
        width = 45,
        height = 45,
        defaultFile = "menu_bt_org.png",
        overFile = "menu_bt_org.png",
        --label = "bt_reload",
        onEvent = function()
          gameState.dialogbox="quit"
           timer.pause(countDownTimer)
           ring:pause()
composer.showOverlay( "quit", options )
        --  gotoMenu
      
      end
    }
)

menu_bt.x = display.contentCenterX-53
menu_bt.y = display.contentCenterY-250                 
  sceneGroup:insert(menu_bt)
-- Center the button


  tile_creation()
  shuffle_tile()
 -- randarr={1}

 --test which will reassign the tile to its place except last one 
i=1
while(i~=9) do
 --randgen()
     --rand=math.random(2, 8)


     imgdisplay[i].x = xpos[i]
imgpos[i]=i
     imgdisplay[i].y = ypos[i]

     i=i+1
  
end
     imgdisplay[8].x = xpos[9]
imgpos[9]=8
imgpos[8]=0
     imgdisplay[8].y = ypos[9]
freepos=8

--[[

    quit = display.newImageRect( sceneGroup, "reload.png", 157, 52 )
    quit.x = display.contentCenterX+125
    quit.y = display.contentCenterY-200

--]]
local fact_bg = display.newImage( sceneGroup, "fact_display2.png",display.contentCenterX, display.contentCenterY+255 )
fact_bg:scale( .55, .55 )


local filepath_facts=system.pathForFile( "fact_dis.json")

local file_fact= io.open( filepath_facts ,"r" )

if(file_fact)then
local contents_f = file_fact:read( "*a" )
fact_table=json.decode( contents_f )
local fact_head =display.newText( sceneGroup, fact_table[2][1], display.contentCenterX+50, display.contentCenterY-250, "CarterOne2.ttf",20 )
local fact_text= display.newText( sceneGroup, fact_table[2][2], display.contentCenterX+10, display.contentCenterY+266 , display.contentWidth-10, 50,"CarterOne2.ttf",12 )
end


local clock_frame = display.newImageRect(sceneGroup,"clock2.png",125,125)
   
   clock_frame.x = ring.x
  clock_frame.y = ring.y

local background = display.newImageRect(sceneGroup,"grid3.png", 300, 300 )
background.x = display.contentCenterX
background.y = display.contentCenterY+67



end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

    loadtime()
   -- print(filePath)
   

        countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
		  Runtime:addEventListener("enterFrame", Update)


    


  --  local Quit = display.newText( sceneGroup, "High Scores", display.contentCenterX, 810, native.systemFont, 44 )
   -- highScoresButton:setFillColor( 0.75, 0.78, 1 )

    --quit:addEventListener( "tap", endGame )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
    print("Entered hide....but what happened")
        puztime = false
        print(secondsLeft)
        --timer.performWithDelay( 1000, endGame )
      --  timer.cancel(countDownTimer) 
        Runtime:removeEventListener( "enterFrame", Update )
        
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
  --composer.removeScene( "game" )


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

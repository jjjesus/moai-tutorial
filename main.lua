--[[
http://www.gamefromscratch.com/page/Moai-tutorial-series-The-adventures-of-an-intrepid-programmer-in-the-lands-of-Moai.aspx

]]--

pinkScreen = function()
  screenWidth = MOAIEnvironment.screenWidth
  screenHeight = MOAIEnvironment.screenHeight
  print("Starting up on:" .. MOAIEnvironment.osBrand  .. 
    " version:" .. MOAIEnvironment.osVersion)

  if screenWidth == nil then screenWidth =640 end
  if screenHeight == nil then screenHeight = 480 end

  MOAISim.openWindow("Window",screenWidth,screenHeight)

  viewport = MOAIViewport.new()
  viewport:setSize(screenWidth,screenHeight)
  viewport:setScale(screenWidth,screenHeight)

  layer = MOAILayer2D.new()
  layer:setViewport(viewport)

  MOAIGfxDevice.setClearColor(1,0.41,0.70,1)
  MOAIRenderMgr:pushRenderPass(layer)
end

smiley = function()
  screenWidth = MOAIEnvironment.screenWidth
  screenHeight = MOAIEnvironment.screenHeight
  print("Starting up on:" .. MOAIEnvironment.osBrand  .. 
    " version:" .. MOAIEnvironment.osVersion)

  if screenWidth == nil then screenWidth =640 end
  if screenHeight == nil then screenHeight = 480 end

  MOAISim.openWindow("Window",screenWidth,screenHeight)

  viewport = MOAIViewport.new()
  viewport:setSize(screenWidth,screenHeight)
  viewport:setScale(screenWidth,screenHeight)

  layer = MOAILayer2D.new()
  layer:setViewport(viewport)
  MOAIGfxDevice.setClearColor(1,1,1,1)

  MOAIRenderMgr.pushRenderPass(layer)

  --Loading in smiley img so it stays in memory
  texture = MOAIImage.new()
  texture:load("smiley.png")

  --Setting up the smiley player
  sprite = MOAIGfxQuad2D.new()
  sprite:setTexture(texture)
  sprite:setRect(-200,-200, 200, 200)

  player = MOAIProp2D.new()
  player:setDeck(sprite)
  player:setLoc(0,5)
  layer:insertProp(player)
end

touch = function()
	screenWidth = MOAIEnvironment.screenWidth
	screenHeight = MOAIEnvironment.screenHeight
	print("Starting up on:" .. MOAIEnvironment.osBrand  .. " version:" .. MOAIEnvironment.osVersion)

	if screenWidth == nil then screenWidth =640 end
	if screenHeight == nil then screenHeight = 480 end

	MOAISim.openWindow("Window",screenWidth,screenHeight)

	viewport = MOAIViewport.new()
	viewport:setSize(screenWidth,screenHeight)
	viewport:setScale(screenWidth,screenHeight)

	layer = MOAILayer2D.new()
	layer:setViewport(viewport)

	MOAIRenderMgr.pushRenderPass(layer)


	sprite = MOAIGfxQuad2D.new()
	sprite:setTexture("smiley.png")
	sprite:setRect(-200,-200,200,200)

	prop = MOAIProp2D.new()
	prop:setDeck(sprite)
	prop:setLoc(0,0)
	layer:insertProp(prop)

	MOAIGfxDevice.setClearColor(1,1,1,1)

	function handleClickOrTouch(x,y)
		prop:setLoc(layer:wndToWorld(x,y))
	end


	if MOAIInputMgr.device.pointer then
		MOAIInputMgr.device.mouseLeft:setCallback(
			function(isMouseDown)
				if(isMouseDown) then
					handleClickOrTouch(MOAIInputMgr.device.pointer:getLoc())
				end
				-- Do nothing on mouseUp
			end
		)
		MOAIInputMgr.device.mouseRight:setCallback(
			function(isMouseDown)
				if(isMouseDown) then
					MOAIGfxDevice.setClearColor(math.random(0,1),math.random(0,1),math.random(0,1),1)
				end
			end
		)
	else
	-- If it isn't a mouse, its a touch screen... or some really weird device.
		MOAIInputMgr.device.touch:setCallback (

			function ( eventType, idx, x, y, tapCount )
				if (tapCount > 1) then
					MOAIGfxDevice.setClearColor(math.random(0,1),math.random(0,1),math.random(0,1),1)
				elseif eventType == MOAITouchSensor.TOUCH_DOWN then
					handleClickOrTouch(x,y)
				end
			end
		)
	end
end

main = function()
  -- pinkScreen()
  -- smiley()
  touch()
end

main()


// Viewport Renderer is a class that handles rendering/drawing of everything

ViewportRenderer = class
  
  constructor = function()
    // "camera" position in the scene (World Space)
    this.Position = new Vector(0, 0)
    
    // distance from Position at which Entities won't be drawn anymore
    this.CullingDistance = 60
    
    // flag deciding if camera is allowed to move
    this.EnableMovement = true
    
    // camera's pan speed
    this.MovementSpeed = 0.4
    
    // value of mouse.x and mouse.y that trigger camera movement
    // TODO: figure out best numbers based on the screen's size
    this.MouseMoveThreshold = new Vector(140, 80)
    
    this.RenderingQueue = new RenderingTaskQueue()
    
    Debug.Info("Viewport Renderer created")
    Debug.Info("Viewport's Culling Distance set to: " + this.CullingDistance)
    Debug.Info("Viewport's Movement enabled?: " + this.EnableMovement)
    Debug.Info("Viewport's Movement Speed: " + this.MovementSpeed)
    Debug.Info("Viewport's Move threshold for mouse: x:" + this.MouseMoveThreshold.X + "; y: " + MouseMoveThreshold.Y)
  end
  
//// Update state of Viewport Renderer
  Update = function()
    // move viewport
    if this.EnableMovement then
      
      // move when mouse cursor is outside of thresholds
      if mouse.x > this.MouseMoveThreshold.X then
        this.Position.X += this.MovementSpeed
      end
      if mouse.x < -this.MouseMoveThreshold.X then
        this.Position.X -= this.MovementSpeed
      end
      if mouse.y > this.MouseMoveThreshold.Y then
        this.Position.Y += this.MovementSpeed
      end
      if mouse.y < -this.MouseMoveThreshold.Y then
        this.Position.Y -= this.MovementSpeed
      end
    end
  end
  
//// Draw all registered Entities
  Draw = function()
    // check if there are any leftower tasks from previous frame
    if this.RenderingQueue.HasTasks() then
      Debug.Error("Leftower Rendering Task from previous frame found. This should not be happening!")
      // clear all old tasks and hope that player won't notice ;)
      this.RenderingQueue.Clear()
    end
    
    // build rendering queue for current frame
    for i = 0 to Config.EntitiesMaxCount-1
      // check all entities
      if Scene.CurrentScene.Entities[i] != 0 then
        // check if entity has Sprite Component for drawing
        local spriteComponent = Scene.CurrentScene.Components.GetSprite(i)
        if spriteComponent != 0 then
          
          // switch by Sprite Type
          
          // case DEFAULT
          if SpriteType.Default == spriteComponent.Type then
            // There should not be any Sprite Components of Default type.
            // It likely means this component is not initialized.
            Debug.Error("Sprite Component of type 'Default' found in the scene. This should not be happening!")
          end
          
          // case UNIT
          if SpriteType.Unit == spriteComponent.Type then
            // calculate distance from camera
            local transform = Scene.CurrentScene.Components.GetTransform(i)
            local distance = this.Position.ChebyshevDistance(transform.Position)
            
            // check if transform is within allowed distance
            if distance <= this.CullingDistance then
              // calculate camera's local position (relative to the viewport)
              local localPosition = transform.Position - this.Position
            
              // add new task to rendering queue
              this.RenderingQueue.AddTask(
                                          RenderTaskType.Unit, 
                                          new RenderingTask(
                                                            spriteComponent.Name, 
                                                            new Vector(localPosition.X, localPosition.Y)))
            end
          end
          
          // case MAP
          if SpriteType.Map == spriteComponent.Type then
            // get map object for ground layer
            local mapName = spriteComponent.Name + "/ground"
            local map = maps[mapName]
            if map != 0 then
              // translate camera's World Space lcoation into Map Space
              local cameraMapPosition = new Vector(
                                                    floor(this.Position.X / map.block_width) + spriteComponent.HalfMapWidth,
                                                    floor(this.Position.Y / map.block_height) + spriteComponent.HalfMapHeight)
                                                  
              // calcualte culling range in Map Blocks
              local mapCullDistance = this.CullingDistance / map.block_width
              
              local minX = ceil(cameraMapPosition.X - mapCullDistance)
              local maxX = ceil(cameraMapPosition.X + mapCullDistance)
              local minY = ceil(cameraMapPosition.Y - mapCullDistance)
              local maxY = ceil(cameraMapPosition.Y + mapCullDistance)
              
              // Draw everything within culling range
              for x = minX to maxX by 1
                for y = minY to maxY by 1
                  
                  // try getting sprite name
                  local spriteName = map.get(x, y)
                  
                  // if sprite under coords exists...
                  if spriteName != 0 then
                    // calculate tile's world position
                    local tileWorldPosition = new Vector(
                                                          (x * map.block_width) - spriteComponent.HalfMapWidthUnits,
                                                          (y * map.block_height) - spriteComponent.HalfMapHeightUnits)
                                                        
                    // calculate camera's local position (relative to the viewport)
                    local localPosition = tileWorldPosition - this.Position
                    
                    // add new task to rendering queue
                    this.RenderingQueue.AddTask(
                                                RenderTaskType.Ground, 
                                                new RenderingTask(
                                                                  spriteName, 
                                                                  new Vector(localPosition.X, localPosition.Y)))
                  end
                  
                end
              end
            else
              Debug.Error("Trying to get map named '"+ mapName +"' but it doesn't have ground layer!")
            end
          end
          
          // end switch
          
        end
      end
    end
    
    local renderingTaskCount = 0
    if Config.Debug then renderingTaskCount = this.RenderingQueue.Count() end
    
    // render all tasks from queue
    while this.RenderingQueue.HasTasks()
      // get next task
      local task = this.RenderingQueue.GetNextTask()
      if task != 0 then
        // get sprite object
        local sprite = sprites[task.Name]
        
        if sprite != 0 then
          // draw sprite
          screen.drawSprite(sprite.name, task.Position.X, task.Position.Y, sprite.width, sprite.height)
        else
          Debung.Error("Trying to get sprite '"+ task.Name +"', but it's not in sprites array!")
        end
      else
        Debug.Error("Trying to get next rendering task, but there's none in the queue!")
      end
    end
    
    // draw debug info on top of everything
    if Config.Debug then
      // draw rendering stats
      screen.drawText("Rendering tasks: "+renderingTaskCount, -100, 95, 6, "rgb(255,255,255)")
      // draw Culling Distance
      local cullingDistanceColour = "rgb(255,0,0)"
      screen.drawText("culling distance", 0, this.CullingDistance+3, 5, cullingDistanceColour)
      screen.drawRect(0, 0, this.CullingDistance * 2, this.CullingDistance * 2, cullingDistanceColour)
      // draw Mouse Movement Thresholds
      local mouseMovementThresholdColour = "rgb(0,255,0)"
      screen.drawText("pan camera border", 0, this.MouseMoveThreshold.Y+3, 5, mouseMovementThresholdColour)
      screen.drawRect(0, 0, this.MouseMoveThreshold.X * 2, this.MouseMoveThreshold.Y * 2, mouseMovementThresholdColour)
    end
  end
  
end
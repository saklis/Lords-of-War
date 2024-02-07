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
    this.MovementSpeed = 0.5
    
    // value of mouse.x and mouse.y that trigger camera movement
    // TODO: figure out best numbers based on the screen's size
    this.MouseMoveThreshold = new Vector(140, 80)
    
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
    // draw all Entities
    for i = 0 to Config.EntitiesMaxCount-1
      // check all entities
      if Scene.CurrentScene.Entities[i] != 0 then
        // check if entity has Sprite Component for drawing
        local spriteComponent = Scene.CurrentScene.Components.GetSprite(i)
        if spriteComponent != 0 then
          // calculate distance from camera
          local transform = Scene.CurrentScene.Components.GetTransform(i)
          local distance = this.Position.ChebyshevDistance(transform.Position)
          
          // check if transform is within allowed distance
          if distance <= this.CullingDistance then
            // calculate camera's local position (relative to the viewport)
            local localPosition = transform.Position - this.Position
            
            // get sprite object
            local sprite = sprites[spriteComponent.Name]
          
            // draw sprite component for this entity
            screen.drawSprite(sprite.name, localPosition.X, localPosition.Y, sprite.width, sprite.height)
          end
        end
      end
    end
    
    // draw debug info on top of everything
    if Config.Debug then
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
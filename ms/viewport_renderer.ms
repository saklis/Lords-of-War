// Viewport Renderer is a class that handles rendering/drawing of everything

ViewportRenderer = class
  
  constructor = function()
    // Entities that will be drawn on the screen
    this.Entities = []
    
    // "camera" position in the scene
    this.Position = new Vector(0, 0)
    
    // distance from Position at which Entities won't be drawn anymore
    this.CullingDistance = 60
    
    // flag deciding if camera is allowed to move
    this.EnableMovement = true
    
    // camera's pan speed
    this.MovementSpeed = 0.5
    
    // value of mouse.x and mouse.y that trigger camera movement
    this.MouseMoveThreshold = new Vector(100, 90)
    
    Debug.Info("Viewport Renderer created")
    Debug.Info("Viewport's Culling Distance set to: " + this.CullingDistance)
    Debug.Info("Viewport's Movement enabled?: " + this.EnableMovement)
    Debug.Info("Viewport's Movement Speed: " + this.MovementSpeed)
    Debug.Info("Viewport's Move threshold for mouse: x:" + this.MouseMoveThreshold.X + "; y: " + MouseMoveThreshold.Y)
  end
  
//// Register checks if provided entity should be drawn on the screen
  // @entityId:int - Id of the Entity to check
  Register = function(entityId)
    transform = Scene.CurrentScene.Components.GetTransform(entityId)
    distance = this.Position.ChebyshevDistance(transform.Position)
    if distance <= this.CullingDistance then
      this.Entities.push(entityId)
    end
  end
  
//// Update state of Viewport Renderer
  Update = function()
    if this.EnableMovement then
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
    if Config.Debug then
      // draw Culling Distance
      screen.drawRect(0, 0, this.CullingDistance * 2, this.CullingDistance * 2, "rgb(255,0,0)")
      // draw Mouse Movement Thresholds
      screen.drawRect(0, 0, this.MouseMoveThreshold.X * 2, this.MouseMoveThreshold.Y * 2, "rgb(0,255,0)")
    end
    
    // draw all registered Entities
    while this.Entities.length > 0
      entityId = this.Entities.pop()
      transform = Scene.CurrentScene.Components.GetTransform(entityId)
      
      // calculate position relative to the viewport
      position = transform.Position - this.Position
      
      // temp drawing, since there's no Sprite Component yet
      screen.fillRect(position.X, position.Y, 10, 10, "rgb(255,255,255)")
    end
  end
  
end
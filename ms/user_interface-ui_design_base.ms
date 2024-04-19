//// UI Design Base is a base class for UI Design, which handles all interactions with UI

UIDesignBase = class
  
//// constructor creates new instance of UI Design
  constructor = function()
    // name of this UI Design
    this.Name = "Base UI Design"
    
    // reference to the scene that this UI is part of
    this.Scene = 0
    
    // distance below which Entity is considered "hit"
    this.HitDistance = 9
  end
  
//// Update state of the UI Design
  Update = function()
    if mouse.press == 1 and mouse.left == 1 then
      HitTrace(mouse.x, mouse.y)
    end
  end
  
//// HitTrace returns an object with information about 'thing' that is under provided coordinates
  // @x:float - X-axis part of coordinates to check
  // @y:float - Y-axis part of coordinates to check
  // @returns:HitInfo - object with info about what's under coordinates.
  HitTrace = function(x, y)
    // CHECK UI
    
    // TODO: handle clicking on UI and move to game world only if not clicking on UI
    
    // CHECK ENTITIES IN GAME WORLD
    
    local worldPosition = Camera.ToWorldCoords(x, y)
    
    // check all entities
    for i = 0 to Config.EntitiesMaxCount-1
      if this.Scene.Entities[i] != 0 then
        local transform = this.Scene.Components.GetTransform(i)
        local distance = transform.Position.ChebyshevDistance(worldPosition)
        
        if distance < HitDistance then Debug.Log("UNIT CLICKED!")
        else Debug.Log("nothing clicked") end
      end
    end
    
    // CHECK MAP
    
    // TODO: handle clicking on map tile
  end
end

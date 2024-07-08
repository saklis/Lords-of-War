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
    
    // walue on X axis (in Camera Space) from where the UI area starts
    this.UiBorderX = 50
    
    // List of Controls in this scene. Elements must extend ControlBase
    this.Controls = []
    
    this.SelectedUnitId = -1
    this.Path = 0
  end
  
//// Update state of the UI Design
  Update = function()
    // mouse left button clicked
    if mouse.press == 1 and mouse.left == 1 then
      local hitInfo = HitTrace(mouse.x, mouse.y)
      
      // switch by hitInfo.Type
      
      // User interface
      if HitInfoType.UI == hitInfo.Type then
        Debug.Log("Clicked! Type: " + hitInfo.Type)
      end
      
      // Unit
      if HitInfoType.Unit == hitInfo.Type then
        Debug.Log("Clicked! Type: " + hitInfo.Type + "; Entity ID: " + hitInfo.Object + "; Hit world pos: " + hitInfo.HitWorldPosition.ToString())
        // select unit
        this.SelectUnit(hitInfo.Object)
      end
      
      // Terrain
      if HitInfoType.Terrain == hitInfo.Type then
        Debug.Log("Clicked! Type: " + hitInfo.Type + "; Terrain tile: " + hitInfo.Object + "; Hit world pos: " + hitInfo.HitWorldPosition.ToString())
      end
      
      // Ground
      if HitInfoType.Ground == hitInfo.Type then
        Debug.Log("Clicked! Type: " + hitInfo.Type + "; Ground tile: " + hitInfo.Object + "; Hit world pos: " + hitInfo.HitWorldPosition.ToString())
        
        // start map coords
        local transformComponent = Scene.Components.GetTransform(this.SelectedUnitId)
        
        local path = this.Scene.Navigator.FindPath(transformComponent.Position, hitInfo.HitWorldPosition, MovementType.Walk)
        if path == 0 then
          Debug.Log("No path to target")
        else
          Debug.Log("Path:")
          for i = 0 to path.length-1
            Debug.Log(i + ". " + path[i].X + ", " + path[i].Y)
          end
        end
        this.Path = path
      end
      
      // switch end
    end
  end
  
//// Draw draws UI
  Draw = function()
    if Config.DebugUI then
      // draw UI background
      local width = 180 - this.UiBorderX
      local centerX = this.UiBorderX + width  / 2
      screen.fillRect(centerX, 0, width, 200, "rgb(255,0,255)")
      
      // draw path
      if this.Path != 0 then
        for node in this.Path
          screen.drawRect(node.X - Camera.Position.X, node.Y - Camera.Position.Y, 16, 16, "rgb(255,255,255)")
        end
      end
    end
    
    screen.drawSprite("ui/mouse_cursor", mouse.x+4, mouse.y-4, 8, 8) // +4 and -4 offset sprite to point at upper/left corner
  end
  
//// HitTrace returns an object with information about 'thing' that is under provided coordinates
  // @x:float - X-axis part of coordinates to check
  // @y:float - Y-axis part of coordinates to check
  // @returns:HitInfo - object with info about what's under coordinates.
  HitTrace = function(x, y)
    local hitInfo = new HitInfo()
    
    // CHECK UI
    
    if x >= this.UiBorderX then
      hitInfo.Type = HitInfoType.UI
      return hitInfo
    end
    
    // CHECK ENTITIES IN GAME WORLD
    
    local worldPosition = Camera.ToWorldCoords(x, y)
    
    // check all entities
    for i = 0 to Config.EntitiesMaxCount-1
      if this.Scene.Entities[i] != 0 then
        local transform = this.Scene.Components.GetTransform(i)
        if transform != 0 then
          local distance = transform.Position.ChebyshevDistance(worldPosition)
          if distance < HitDistance then 
            // unit clicked
            hitInfo.Type = HitInfoType.Unit
            hitInfo.Object = i
            hitInfo.HitWorldPosition = worldPosition
            return hitInfo
          end
        end
      end
    end
    
    // CHECK MAP
      
    local MapSpriteComponent = Scene.GetMap()
    if MapSpriteComponent != 0 then
      // get ref to map object
      local ground = maps[MapSpriteComponent.Name + "/ground"]
      local terrain = maps[MapSpriteComponent.Name + "/terrain"]
      
      // translate world space to map space
      local mapPosition = new Vector(
        MapSpriteComponent.HalfMapWidth + floor(worldPosition.X / ground.block_width + 0.5),
        MapSpriteComponent.HalfMapHeight +  floor(worldPosition.Y / ground.block_height + 0.5)
      )
      
      // check terrain layer  
      local terrainSpriteName = terrain.get(mapPosition.X, mapPosition.Y)
      if terrainSpriteName != 0 then
        // terrain clicked
        hitInfo.Type = HitInfoType.Terrain
        hitInfo.Object = terrainSpriteName
        hitInfo.HitWorldPosition = worldPosition
        return hitInfo
      end
                            
      // check ground layer
      local groundSpriteName = ground.get(mapPosition.X, mapPosition.Y)
      if groundSpriteName != 0 then
        // ground clicked
        hitInfo.Type = HitInfoType.Ground
        hitInfo.Object = groundSpriteName
        hitInfo.HitWorldPosition = worldPosition
        return hitInfo
      end
    else
      Debug.Error("Unable to get reference to Map Sprite Component. Is this a scene without a map?!")
    end
    
    return hitInfo
  end
  
//// SelectUnit stores the reference to the unit with provided Entity Id as 'selected'
  // @entityId:int - id of entity that represents selected unit
  SelectUnit = function(entityId)
    Debug.Log("Selecting Unit ID: " + entityId)
    this.SelectedUnitId = entityId
  end
  
//// DeselectUnit clears reference to a unit with 'selected' status
  DeselectUnit = function()
    this.SelectedUnitId = -1
  end
end

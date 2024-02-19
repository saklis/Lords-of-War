// Component that hold info about sprite to be rendered
SpriteComponent = class extends ComponentBase
  
//// constructor creates new instance of Sprite Component
  constructor = function()
    super()
    
    // Name of the sprite file to display
    this.Name = ""
    
    // Type of sprite. Will impact drawing
    this.Type = SpriteType.Unit
    
    // ### Map sizes only available if this.Type == SpriteType.Map
    
    // Cached result of dividing map dimensions by 2 in Map system coord
    this.HalfMapWidth = 0
    this.HalfMapHeight = 0
    
    // Cached result of dividing map dimensions by 2 in World units
    this.HalfMapWidthUnits = 0
    this.HalfMapHeightUnits = 0
  end
  
//// InitAsMap initializes all fields of this Sprite Component as a representation of map.
  // @mapName - name of map folder
  InitAsMap = function(mapName)
    this.Name = mapName
    this.Type = SpriteType.Map
    
    // 'ground' is a mandatory element of all maps - if it doesn't exists, there's no map
    local ground = maps[this.Name + "/ground"]
    if ground != 0 then
      this.HalfMapWidth = ground.width / 2
      this.HalfMapHeight = ground.height / 2
      this.HalfMapWidthUnits = ground.width * ground.block_width / 2
      this.HalfMapHeightUnits = ground.height * ground.block_height / 2
      Debug.Info("Map sprite '"+this.Name+"' loaded.")
      Debug.Info("> Half width: "+this.HalfMapWidth+"; Half height: "+this.HalfMapHeight)
      Debug.Info("> Half width units: "+this.HalfMapWidthUnits+"; Half height units: "+this.HalfMapHeightUnits)
    else
      Debug.Error("Creating a Map Sprite for name '"+this.Name+"' but ground layer not found!")
    end
  end
end
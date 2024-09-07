// NavigationManager hold navigation data and calculates path
NavigationManager = class
  constructor = function()
    // NavGrid holds information about map required for pathfinding
    this.NavGrid = []
    
    // name of map that was last used to generate NavGrid
    this.MapName = ""
  end
  
//// GenerateNavData initializes all data required for navigation based on supplied map name
  // @mapName:string - name of the map that should be used to generate navigation data
  GenerateNavData = function(mapName)
    this.NavGrid = [] // clear
    
    this.MapName = mapName
    
    local groundName = this.MapName + "/ground"
    local ground = maps[groundName]
    
    local terrainName = this.MapName + "/terrain"
    local terrain = maps[terrainName]
    
    if ground != 0 then 
      // init NavGrid
      for x=0 to ground.width-1
        this.NavGrid.push([])
        for y=0 to ground.height-1
          local node = new NavGridNode(x, y)

          local groundTile = ground.get(x, y)
            
          if groundTile == "terrain/grass" then
            node.IsFlyable = true
            node.IsWalkable = true
          end
          if groundTile == "terrain/water" then
            node.IsFlayable = true
            node.IsSwimable = true
          end
          
          if terrain != 0 then
            local terrainTile = terrain.get(x, y)
            
            if terrainTile == "terrain/mountains" then
              node.IsFlyable = true
              node.IsWalkable = false
              node.IsSwimable = false
            end
          end
          
          this.NavGrid[x].push(node)
        end
      end
      
      Debug.Log("NavGrid for '"+this.MapName+"' created.")
      
    else Debug.Error("Generation of nav data failed! Map " + this.MapName + " not found") end
  end
  
//// FindPath find path to the goal
  // @start:vector - position of start point in world space
  // @goal:vector - position of goal in world space
  // @returns:vector[] - list of positions that form a path to goal in world space. Returns 0 if path not found
  FindPath = function(start, goal, movementType)
    
    local map = maps[this.MapName + "/ground"]
    local halfMapWidth = map.width / 2
    local halfMapHeight = map.height / 2
    local halfMapWidthUnits = map.width * map.block_width / 2
    local halfMapHeightUnits = map.height * map.block_height / 2
    
    local mapStart = new Vector(
      halfMapWidth + floor(start.X / map.block_width + 0.5),
      halfMapHeight +  floor(start.Y / map.block_height + 0.5)
    )
    
    local mapGoal = new Vector(
      halfMapWidth + floor(goal.X / map.block_width + 0.5),
      halfMapHeight +  floor(goal.Y / map.block_height + 0.5)
    )
    
    local astar = new AStar(this.NavGrid)
    local path =  astar.FindPath(mapStart, mapGoal, movementType)
    
    // if path exists, return list of vectors in world space
    if path != 0 then
      local worldPath = []
      for node in path
        local nodeWorldPosition = new Vector(
          (node.X * map.block_width) - halfMapWidthUnits,
          (node.Y * map.block_height) - halfMapHeightUnits)
        worldPath.push(nodeWorldPosition)
      end
      return worldPath
    else
      return 0
    end
  end
  
//// GetWorldFromMapSpace returns a Vector with position in World Space calculated from supplied Map Space coords.
  // @mapPosition:Vector - position in Map Sapce
  // returns:Vector - position in World Space
  GetWorldFromMapSpace = function(mapPosition)
    local map = maps[this.MapName + "/ground"]
    local halfMapWidthUnits = map.width * map.block_width / 2
    local halfMapHeightUnits = map.height * map.block_height / 2
    
    return nodeWorldPosition = new Vector(
          (mapPosition.X * map.block_width) - halfMapWidthUnits,
          (mapPosition.Y * map.block_height) - halfMapHeightUnits)
  end
  
end
// AStar class calculates a path using A* algorithm
AStar = class
  
//// Create instance of AStar class
  // @navGrid:unknown - reference to navGrid that is base for patchfinding
  constructor = function(navGrid)
    // NavGrid is a grid that describes all properties of the game world required for patchfinding
    this.NavGrid = navGrid
    
    // priority queue that contains nodes to be evaluated - part of A* algo
    this.OpenList = []
    
    // list of evaluated nodes - part of A* algo
    this.ClosedList = []
    
    // private. Holds list of all directions.
    this._directions = [
        [0, -1], [0, 1], [-1, 0], [1, 0], // up, down, left, right
        [-1, -1], [1, -1], [-1, 1], [1, 1] // diagonals
      ]
  end
  
//// Find Path returns list of nodes that form path to the goal.
  // @start:vector - location of start
  // @goal:vector - location of goal
  // @movementType:MovementType - type of movement that applies to this path
  // @returns:NavGridNode[] - list of nodes that form a path. Returns 0 if no path was found
  FindPath = function(start, goal, movementType)
    this.OpenList = [] // clear
    this.ClosedList = [] // clear
    
    local firstNode = this.NavGrid[start.X][start.Y]
    firstNode.Parent = 0
    firstNode.F = 0
    
    this.OpenList.push(firstNode)
    
    while this.OpenList.length > 0
      local currentNode = GetOpenNodeWithSmallestF()
      
      if currentNode.X == goal.X and currentNode.Y == goal.Y then
        return this.ReconstructPath(currentNode)
      end
      
      this.OpenList.removeElement(currentNode)
      this.ClosedList.push(currentNode)
      
      local neighbors = GetNeighbors(currentNode, movementType)
      for neighbor in neighbors
        // skip if node already in ClosedList
        if this.ClosedList.indexOf(neighbor) != -1 then
          continue 
        end
        
        local tentativeG = currentNode.G + neighbor.MoveCost
        
        // if not in open list, add
        if this.OpenList.indexOf(neighbor) == -1 then
          this.OpenList.push(neighbor)
        elsif tentativeG >= neighbor.G then
          continue
        end
        
        neighbor.Parent = currentNode
        neighbor.G = tentativeG
        neighbor.H = this.Heuristic(neighbor, goal)
        neighbor.F = neighbor.G + neighbor.H
      end
    end

    return 0 // no path found
  end
  
//// Reconstruct Path build list of nodes from current state
  // @lastNode:NavGridNode - last node of the path
  ReconstructPath = function(lastNode)
    local path = []
    
    local currentNode = lastNode
    while currentNode != 0
      path.push(currentNode)
      currentNode = currentNode.Parent
    end
    
    path.reverse()
    
    return path
  end
  
//// Get Open Node Smallest F returns a node from OpenNode list with smallest F.
  GetOpenNodeWithSmallestF = function()
    local smallestNode = this.OpenList[0] // checking if OpenList has at least 1 element shouldn't be needed
    
    for node in this.OpenList
      if node.F < smallestNode.F then smallestNode = node end
    end
    
    return smallestNode
  end
  
//// The heuristic estimate of the cost from the current node to the goal.
  // @node:NavGridNode - postion of current node
  // @goal:NavGridNode - position of goal node
  // @returns:int - estimated distance from node to goal
  Heuristic = function(node, goal)
    // Chebyshev Distance
    return max(abs(goal.X - node.X), abs(goal.Y - node.Y))
  end
  
//// GetNeighbors returns a list of nodes accesigble from passed node.
  // @node:NavGridNode - position of current node
  // @movementType:MovementType - type of movement that applies to this path
  // @returns:NavGridNode[] - list of neighboring nodes
  GetNeighbors = function(node, movementType)
    local neighbors = []
    
    for direction in _directions
      local x = node.X + direction[0]
      local y = node.Y + direction[1]
     
      if x >= 0 and x < this.NavGrid.length and y >= 0 and y < this.NavGrid[x].length then
        
        // Switch by movementType
        if MovementType.Walk == movementType then
          if this.NavGrid[x][y].IsWalkable then
            neighbors.push(this.NavGrid[x][y])
          end
        end
        
        if MovementType.Swim == movementType then
          if this.NavGrid[x][y].IsSwimable then
            neighbors.push(this.NavGrid[x][y])
          end
        end
        
        if MovementType.Fly == movementType then
          if this.NavGrid[x][y].IsFlyable then
            neighbors.push(this.NavGrid[x][y])
          end
        end
        // Switch end
        
      end
    end
    
    return neighbors
  end
  
end
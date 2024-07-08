// Nav Grid Node stores data required for pathfinding for particular node of a NavGrid
NavGridNode = class
  
//// Create new instance of NavGrid Node
  // @x:int - position of this node in NavGrid on X axis
  // @y:int - position of this node in NavGrid on Y axis
  constructor = function(x, y)
    // position in the NavGrid
    this.X = x
    this.Y = y
    
    // Can this node be traversed by particular MovementType?
    this.IsWalkable = false
    this.IsSwimable = false
    this.IsFlyable = false
    
    // how much it costs to step into this node
    this.MoveCost = 1
    
    // total esitmated cost (G + H) - part of A* algo
    this.F = 0
    
    // distance from start node - part of A* algo
    this.G = 0
    
    // heuristic distance from this node to the goal - part of A* algo
    this.H = 0
    
    // reference to previous Node in path - part of A* algo
    this.Parent = 0
  end
end
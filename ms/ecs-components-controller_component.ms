// Component that hold info required for this entity to be controled by User or by Computer player
ControllerComponent = class extends ComponentBase
  
//// construct new instance
  // @entityId:int - Id of the Entity this component belong to
  constructor = function(entityId)
    super(entityId)
    
    // Current path planned for this entity
    this.CurrentPath = 0
    
    // is currently moving along the planned path?
    this.IsMoving = false
    
    // speed of movement for player-controlled entites
    this.PlayerSpeed = 0.35
    this.PlayerMoveThreshold = 1 // distance from goal. When under that threshold, entity will just snap to goal position and movement will be canceled
  end
  
//// Move along the planned path
  Move = function()
    Debug.Log("Start moving...")
    this.IsMoving = true
  end
  
//// Update is called every tick
  Update = function()
    // if IS MOVING...
    if IsMoving then
      // try get next node (goal) from currently planned path
      local nextNode = this.CurrentPath[1]
      if nextNode != 0 then
        local transform =  Scene.Current.Components.GetTransform(this.EntityId)
        if transform != 0 then
          // check how far away you are from the goal...
          local distance = nextNode.ChebyshevDistance(transform.Position)
          
          // if still further than threshold, then move closer to goal
          if distance > this.PlayerMoveThreshold then
            local movementDir = nextNode - transform.Position
            movementDir.Normalize()
            
            transform.Position.X += movementDir.X * PlayerSpeed
            transform.Position.Y += movementDir.Y * PlayerSpeed
          else
            // when close enough, snap entity to goal location
            transform.Position.X = nextNode.X
            transform.Position.Y = nextNode.Y
            // remove current goal from the list
            this.CurrentPath.removeAt(0)
          end
        end
      else
        // if there is no next node, then we can stop moving
        IsMoving = false
        this.CurrentPath = []
      end
    end
  end
end
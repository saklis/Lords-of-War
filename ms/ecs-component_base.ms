// Base class for all Components
ComponentBase = class
  
//// construct new instance
  // @entityId:int - Id of the Entity this component belong to
  constructor = function(entityId)
    // Id of the Entity this component belong to
    this.EntityId = entityId
  end
  
//// Update is called every tick
  Update = function()
  end
end
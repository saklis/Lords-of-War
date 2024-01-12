// Holds collections of components

ComponentManager = class

//// constructor creates new instance of ComponentManager
  constructor = function()
    // Transform Components
    this.Transforms = []
    
    // INITIALISE
    
    // init Transform Component's list
    for i = 0 to Config.EntitiesMaxCount-1
      this.Transforms.push(0)
    end
  end
  
//// Create new component
  // @entityId:int - Id of the entity that will have Component attached
  // @componentClass:Component - class of the component to create
  CreateComponent = function(entityId, componentClass)
    // is Transform Component
    if TransformComponent == componentClass then
      this.Transforms[entityId] = new TransformComponent()
      Debug.Log("Transform Component created for entity: " + entityId)
    end
  end
  
//// CountAll() counts and returns the number of all existing components
  // @returns:int - number of all components
  CountAll = function()
    transformsCount = 0
    for i = 0 to Config.EntitiesMaxCount-1
      if this.Transforms[i] != 0 then transformsCount += 1 end
    end
    return transformsCount
  end
  
//// GetTransform returns Transform Component for Entity with provided Id.
  // @entityId:int - Id of Entity
  // @returns Transform Component of the Entity
  GetTransform = function(entityId)
    return this.Transforms[entityId]
  end
  
end
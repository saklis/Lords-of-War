// Holds collections of components

ComponentManager = class

//// constructor creates new instance of ComponentManager
  constructor = function()
    // Transform Components
    this.Transforms = []
    
    // INITIALISE
    
    // init Transform Component's list
    for i = 0 to Config.EntitiesMaxNumber-1
      this.Transforms.push(0)
    end
  end
  
//// Create new component
  // @entityId:int - Id of the entity that will have Component attached
  // @componentClass:class:Component - class of the component to create
  CreateComponent = function(entityId, componentClass)
    Debug.Log("Creating component. entity:" + entityId + "; class:" + componentClass)
    
    // is Transform Component
    if TransformComponent == componentClass then
      this.Transforms[entityId] = new TransformComponent()
    end
  end
  
//// CountAll() counts and returns the number of all existing components
  // @returns:int - number of all components
  CountAll = function()
    return 42 // mock
  end
  
end
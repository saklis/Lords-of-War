// Holds collections of components

ComponentManager = class

//// constructor creates new instance of ComponentManager
  constructor = function()
    // Transform Components
    this.Transforms = []
    
    // Sprite components
    this.Sprites = []
    
    // INITIALISE
    
    // init Transform Component's list
    for i = 0 to Config.EntitiesMaxCount-1
      this.Transforms.push(0)
      this.Sprites.push(0)
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
    
    // is Sprite Component
    if SpriteComponent == componentClass then
      this.Sprites[entityId] = new SpriteComponent()
      Debug.Log("Sprite Component created for entity: " + entityId)
    end
  end
  
//// CountAll() counts and returns the number of all existing components
  // @returns:int - number of all components
  CountAll = function()
    local transformsCount = 0
    local spritesCount = 0
    for i = 0 to Config.EntitiesMaxCount-1
      if this.Transforms[i] != 0 then transformsCount += 1 end
      if this.Sprites[i] != 0 then spritesCount += 1 end
    end
    return transformsCount + spritesCount
  end
  
//// GetTransform returns Transform Component for Entity with provided Id.
  // @entityId:int - Id of Entity
  // @returns Transform Component of the Entity
  GetTransform = function(entityId)
    return this.Transforms[entityId]
  end
  
//// GetSprite returns Sprite Component for Entity with provided Id.
  // @entityId:int - Id of Entity
  // @returns Sprite Component of the Entity
  GetSprite = function(entityId)
    return this.Sprites[entityId]
  end
  
end
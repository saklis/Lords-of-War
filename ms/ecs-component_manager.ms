// Holds collections of components

ComponentManager = class

//// constructor creates new instance of ComponentManager
  constructor = function()
    // Transform Components
    this.Transforms = []
    
    // Sprite components
    this.Sprites = []
    
    // Controller components
    this.Controllers = []
    
    // Cashes reference to map Sprite Component
    this.Map = 0
    
    // INITIALISE
    
    // init Transform Component's list
    for i = 0 to Config.EntitiesMaxCount-1
      this.Transforms.push(0)
      this.Sprites.push(0)
      this.Controllers.push(0)
    end
  end
  
//// Create new component
  // @entityId:int - Id of the entity that will have Component attached
  // @componentClass:Component - class of the component to create
  CreateComponent = function(entityId, componentClass)
    // is Transform Component
    if TransformComponent == componentClass then
      this.Transforms[entityId] = new TransformComponent(entityId)
    end
    
    // is Sprite Component
    if SpriteComponent == componentClass then
      this.Sprites[entityId] = new SpriteComponent(entityId)
    end
    
    // is Controller Component
    if ControllerComponent == componentClass then
      this.Controllers[entityId] = new ControllerComponent(entityId)
    end
  end
  
//// CountAll() counts and returns the number of all existing components
  // @returns:int - number of all components
  CountAll = function()
    local transformsCount = 0
    local spritesCount = 0
    local controllersCount = 0
    for i = 0 to Config.EntitiesMaxCount-1
      if this.Transforms[i] != 0 then transformsCount += 1 end
      if this.Sprites[i] != 0 then spritesCount += 1 end
      if this.Controllers[i] != 0 then controllersCount += 1 end
    end
    return transformsCount + spritesCount + controllersCount
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
  
//// GetController returns Controller Component for Entity with provided Id.
  // @entityId:int - Id of Entity
  // @returns Controller Component of the Entity
  GetController = function(entityId)
    return this.Controllers[entityId]
  end
  
//// GetMap returns a reference to map's Sprite Component. If there's more than one, first will be returned.
  // @returns map's Sprite Component. 0 if Sprite Component was not found.
  GetMap = function()
    if Map != 0 then
      return Map
    else
      for i = 0 to Config.EntitiesMaxCount-1
        if this.Sprites[i] != 0 and this.Sprites[i].Type == SpriteType.Map then
          Map = this.Sprites[i]
          return this.Sprites[i]
        end
      end
    end
    
    return 0
  end
  
end
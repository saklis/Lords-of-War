// Base class for all scenes
SceneBase = class
  
//// constructor creates new instance of Scene class
  constructor = function()
    // Name of this scene
    this.Name = "Default name"
    
    // List of entities in this scene
    this.Entities = []
    
    // Components of entities
    this.Components = new ComponentManager()
    
    // UI Design for this scene
    this.UI = 0
    
    // Navigation functionality
    this.Navigator = new NavigationManager()
    
    // INITIALISE
    
    // Init Entity list
    for i = 0 to Config.EntitiesMaxCount-1
      this.Entities.push(0)
    end
  end
  
//// AddEntity adds new Entity to this scene.
  // @name:string - name of new entity
  // @returns - id of the new Entity. -1 in case of an error
  AddEntity = function(name = "Entity")
    local newEntityId = -1
    
    // find empty space in entity list
    for i = 0 to Config.EntitiesMaxCount-1
      if this.Entities[i] == 0 then
        newEntityId = i
        break
      end
    end
    
    if newEntityId != -1 then
      this.Entities[newEntityId] = new Entity(newEntityId, name)
    else
      Debug.Error("No space for new Entity")
    end
    
    return newEntityId
  end
  
//// AddComponent adds component to existing Entity
  // @entityId:int - Id of the entity that will have Component attached
  // @componentClass:class:Component - class of the component to create
  AddComponent = function(entityId, componentClass)
    this.Components.CreateComponent(entityId, componentClass)
  end
  
//// GetMap returns a reference to map's Sprite Component. If there's more than one, first will be returned.
  // @returns map's Sprite Component. 0 if Sprite Component was not found.
  GetMap = function()
    return Components.GetMap()
  end
  
//// EntitiesCount returns number of Entities in the scene
  // @returns number of Entities
  EntitiesCount = function()
    local entitiesCount = 0
    for i = 0 to Config.EntitiesMaxCount-1
      if this.Entities[i] != 0 then entitiesCount += 1 end
    end
    
    return entitiesCount
  end
  
//// Update updates all entities in this scene
  Update = function()
    // update UI
    if this.UI != 0 then
      this.UI.Update()
    end
    
    // update entities/components
    for i = 0 to Config.EntitiesMaxCount-1
      if this.Entities[i] != 0 then
        local controller = Components.GetController(i)
        if controller != 0 then
          controller.Update()
        end
      end
    end
  end
  
//// AddUIDesign registers the providded UI Design as UI for this scene.
  // @uiDesign:UIDesignBase - reference to UI Design object that will handele UI for this scene
  AddUIDesign = function(uiDesign)
    this.UI = uiDesign
    this.UI.Scene = this
    Debug.Log("UI Design '"+this.UI.Name+"' added to scene '"+this.Name+"'.")
  end

end
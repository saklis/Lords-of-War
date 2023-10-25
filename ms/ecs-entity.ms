// represents entity in the game world

Entity = class
  // Next number for Entity unique identifiers
  NextEntityId = 0
  
//// constructor creates new entity
  // @name:string - name of the entity
  constructor = function(name = "entity")
    // Entity's unique identifier
    this.Id = Entity.NextEntityId
    
    // increase the class static property to count number of entities
    Entity.NextEntityId += 1 // increase instance count
    
    this.Name = name + "_" + Id
  end
end
// represents entity in the game world

Entity = class

//// constructor creates new entity
  // @id:int - this entity's unique identifier
  // @name:string - name of the entity
  constructor = function(id, name = "entity")
    // Entity's unique identifier
    this.Id = id
    
    this.Name = name + "_" + Id
    
    Debug.Log("Entity created! Id:" + this.Id + "; Name:" + this.Name)
  end
end
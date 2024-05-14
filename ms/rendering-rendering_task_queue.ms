// Rendering Task Queue is a que object that manages Rendering Tasks and the serves it back in correct order for rendering
RenderingTaskQueue = class
  
//// constructor creates new instance of Rendering Task Queue.
  constructor = function()
    this.Units = []
    this.Grounds = []
    this.Terrains = []
  
    Debug.Info("Rendering Task Queue created")
  end
  
//// AddTask allows to add new task into the queue
  // @taskType:SpriteType - type of the sprite in the task
  // @newTask:RenderingTask - new task to be added to the queue
  AddTask = function(taskType, newTask)
    // switch for taskType
    if RenderTaskType.Unit == taskType then
      this.Units.push(newTask)
    end
    if RenderTaskType.Ground == taskType then
      this.Grounds.push(newTask)
    end
    if RenderTaskType.Terrain == taskType then
      this.Terrains.push(newTask)
    end
    // end switch
  end
  
//// Get Next Task returns next task to be drawn. Removes returned task from the queue
  // @return next task for drawing. Returns 0 if there's no more tasks
  GetNextTask = function()
    if this.Grounds.length > 0 then
      local current = this.Grounds.length - 1
      local task = this.Grounds[current]
      this.Grounds.removeAt(current)
      return task
    end
    
    if this.Terrains.length > 0 then
      local current = this.Terrains.length - 1
      local task = this.Terrains[current]
      this.Terrains.removeAt(current)
      return task
    end
    
    if this.Units.length > 0 then
      local current = this.Units.length - 1
      local task = this.Units[current]
      this.Units.removeAt(current)
      return task
    end
    
    return 0
  end
  
//// Has Tasks returns true, if queue has more tasks to process
  // @returns true if there's more tasks. False otherwise
  HasTasks = function()
    if this.Units.length > 0 or this.Grounds.length > 0 or this.Terrains.length > 0 then 
      return true
    else 
      return false
    end
  end
  
//// Count returns a number of Rendering Tasks in all lists
  Count = function()
    return (this.Grounds.length + this.Units.length + this.Terrains.length)
  end
  
//// Clear removes all Rendering Tasks
  Clear = function()
    this.Units.clear()
    this.Grounds.clear()
    this.Terrains.clear()
  end
end
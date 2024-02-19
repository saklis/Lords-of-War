//// Rendering Task is a class responsible for holding required information for drawing on the screen
RenderingTask = class
  
//// constructor creates new instance of Rendering Task
  // @name:string - name of the sprite file
  // @position:Vecotr - position of the sprite on the screen
  constructor = function(name, position)
    // Name of the sprite to draw
    this.Name = name
  
    // Position of the sprite on the screen, in camera's local coordinates.
    this.Position = position
  end
end